#!/usr/bin/env bash

set -euo pipefail
set +u

# --- Configuration ---
APP_NAME="fuzzel-colors"
THEME_NAME="kanso"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/$APP_NAME"
ICONS_DIR="$CONFIG_DIR/icons/$THEME_NAME"

mkdir -p "$ICONS_DIR"

FUZZEL_DMENU_BASE_ARGS="--dmenu"

# Colors file path
# The user can override this by setting the environment variable
# e.g., COLORS_FILE=/path/to/my/colors.json ./fuzzel-colors.sh
: "${COLORS_FILE:=$XDG_DATA_HOME/colors/$THEME_NAME.json}"

# --- Helper Functions ---

# Function to send desktop notifications
notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &>/dev/null; then
        notify-send --app-name="$APP_NAME" "$title" "$message"
    else
        # Fallback if notify-send is not available
        echo "Notification: $title - $message" >&2
    fi
}

# Function to copy to clipboard
copy_to_clipboard() {
    local text="$1"
    if command -v wl-copy &>/dev/null; then
        echo -n "$text" | wl-copy
        return 0
    elif command -v xclip &>/dev/null; then
        echo -n "$text" | xclip -selection clipboard
        return 0
    else
        return 1
    fi
}

# Function to run fuzzel with given prompt, input data, and optional extra arguments
# Usage: run_fuzzel "Prompt:" "Input string" "Extra fuzzel args (e.g., -l 5)"
run_fuzzel() {
    local prompt="$1"
    local input_data="$2"
    local extra_args="${3:-}"

    if [[ -z "$input_data" ]]; then
        # Use existing stdin pipe if input_data is empty
        fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    else
        # Echo input_data to fuzzel
        echo "$input_data" | fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    fi
}

# --- MODIFIED FUNCTION ---
# Takes the hex code and the full icon path as arguments.
# This makes it more robust and prevents issues with '#' in filenames.
function generate_svg_icon() {
    local color="$1"
    local icon_path="$2"

    # Create an SVG for the color if it doesn't exist
    if [ ! -f "$icon_path" ]; then
        # Ensure the parent directory exists
        mkdir -p "$(dirname "$icon_path")"
        cat >"$icon_path" <<EOF
<svg width="128" height="128" xmlns="http://www.w3.org/2000/svg">
  <rect width="128" height="128" fill="$color" />
</svg>
EOF
    fi
}

# --- REPLACED FUNCTION 1 ---
# This uses a more robust jq query to find only hex color codes
# and outputs them in a machine-readable, tab-separated format:
# #hexcode\tkey1\tkey2\t...
parse_colors_from_json() {
    if [[ ! -f "$COLORS_FILE" ]]; then
        notify "Color Utils Error" "Colors file not found at $COLORS_FILE"
        return 1
    fi

    if ! command -v jq &>/dev/null; then
        notify "Color Utils Error" "jq is not installed, required to parse JSON colors file."
        return 1
    fi

    # 1. Find all paths to scalar values.
    # 2. Get the value for each path.
    # 3. Filter to keep only values that look like a hex color code.
    # 4. Create an array with the [value, key1, key2, ...]
    # 5. Format the output as a Tab-Separated Value (TSV) string.
    jq -r '
        paths(scalars) as $p
        | getpath($p) as $v
        | select($v | test("^#[0-9a-fA-F]{3,8}$"))
        | [$v] + $p | @tsv
    ' "$COLORS_FILE"
}

# --- Color Utils Actions ---

# Pick color using hyprpicker with format: HEX, RGB, HSL, etc.
pick_with_hyprpicker() {
    if ! command -v hyprpicker &>/dev/null; then
        notify "Color Utils Error" "hyprpicker is not installed"
        return 1
    fi

    local format="${1,,}"              # Convert to lowercase, as hyprpicker expects it
    [[ -z "$format" ]] && format="hex" # Default to hex if empty

    notify "Color Utils" "Click on any pixel to pick its color..."

    local color
    if color=$(hyprpicker -a -f "$format" 2>/dev/null); then
        # hyprpicker outputs with # for hex, e.g., "#RRGGBB"
        if copy_to_clipboard "$color"; then
            notify "Color Utils" "Picked color ($format): $color (copied to clipboard)"
        else
            notify "Color Utils" "Picked color ($format): $color (failed to copy to clipboard)"
        fi
    else
        notify "Color Utils" "Color picking cancelled"
    fi
}

# Pick color using niri
pick_with_niri() {
    notify "Color Utils" "Click on any pixel to pick its color..."

    local color
    if color=$(niri msg pick-color 2>/dev/null); then
        # niri msg pick-color returns format like "sRGB: #RRGGBB"
        # Extract just the hex code
        color=$(echo "$color" | grep -oE '#[0-9A-Fa-f]{6}' | head -1)

        if [[ -n "$color" ]]; then
            if copy_to_clipboard "$color"; then
                notify "Color Utils" "Picked color: $color (copied to clipboard)"
            else
                notify "Color Utils" "Picked color: $color (failed to copy to clipboard)"
            fi
        else
            notify "Color Utils Error" "Failed to parse color from niri output"
        fi
    else
        notify "Color Utils" "Color picking cancelled"
    fi
}

# --- REPLACED FUNCTION 2 ---
# This now reads the tab-separated output from parse_colors_from_json
# and uses printf to create padded columns for better alignment in fuzzel.
build_color_palette() {
    local colors_data
    if ! colors_data=$(parse_colors_from_json); then
        return 1
    fi

    if [[ -z "$colors_data" ]]; then
        notify "Color Utils" "No colors found in $COLORS_FILE"
        return 1
    fi

    # Process the tab-separated data line by line
    echo "$colors_data" | while IFS=$'\t' read -ra parts; do
        # Skip empty lines that might result from the pipe
        [[ ${#parts[@]} -eq 0 ]] && continue

        local hex="${parts[0]}"
        # Sanitize hex code for use in a filename by removing the '#'
        local filename_hex="${hex#\#}"
        local icon_path="$ICONS_DIR/$filename_hex.svg"

        # Generate the icon if it doesn't exist
        generate_svg_icon "$hex" "$icon_path"

        # --- PADDING LOGIC ---
        # Get path components. Use :- to provide an empty default if a key doesn't exist.
        local key1="${parts[1]:-}"
        # Join the rest of the keys (from the 3rd element onwards) with a space
        local key_rest=$(IFS=' '; echo "${parts[*]:2}")

        # Use printf to format the text with padding, similar to your awk command
        # %-15s means "left-align and pad with spaces to 15 characters"
        local formatted_text
        formatted_text=$(printf "%-15s %-15s %s" "$hex" "$key1" "$key_rest")
        # --- END PADDING LOGIC ---

        # Print the final entry for fuzzel, combining the padded text and the icon path
        echo -e "${formatted_text}\0icon\x1f$icon_path"
    done
}


show_color_palette() {
    local selected
    # build_color_palette now handles the formatting, so we just pipe its output
    selected=$(build_color_palette | fuzzel --dmenu --prompt="Select color: " -l 10)

    if [[ -n "$selected" ]]; then
        # This still works because '%% *' will stop at the first block of spaces,
        # correctly isolating the hex code.
        local hex="${selected%% *}"
        if copy_to_clipboard "$hex"; then
            notify "Color Utils" "Copied $hex to clipboard"
        else
            notify "Color Utils" "Selected $hex (failed to copy to clipboard)"
        fi
    fi
}

# --- Main Logic ---

main() {
    local main_menu_options=$(
        cat <<EOF
⊹ Pick Color [Hyprpicker] [HEX]
⊹ Pick Color [Hyprpicker] [RGB]
⊹ Pick Color [Hyprpicker] [CMYK]
⊹ Pick Color [Hyprpicker] [HSL]
⊹ Pick Color [Hyprpicker] [HSV]
⊹ Pick Color [Niri] [HEX]
⊹ Color Palette [${THEME_NAME^}]
EOF
    )

    # Calculate the exact number of lines for the main menu
    local num_main_options=$(echo -e "$main_menu_options" | wc -l)
    local main_menu_specific_args="-l $num_main_options"

    local choice
    # Pass the calculated line count to run_fuzzel for the main menu
    choice=$(run_fuzzel "λ " "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "⊹ Pick Color [Hyprpicker] [HEX]")
        pick_with_hyprpicker "HEX"
        ;;
    "⊹ Pick Color [Hyprpicker] [RGB]")
        pick_with_hyprpicker "RGB"
        ;;
    "⊹ Pick Color [Hyprpicker] [CMYK]")
        pick_with_hyprpicker "CMYK"
        ;;
    "⊹ Pick Color [Hyprpicker] [HSL]")
        pick_with_hyprpicker "HSL"
        ;;
    "⊹ Pick Color [Hyprpicker] [HSV]")
        pick_with_hyprpicker "HSV"
        ;;
    "⊹ Pick Color [Niri] [HEX]")
        pick_with_niri
        ;;
    "⊹ Color Palette [${THEME_NAME^}]")
        show_color_palette
        ;;
    *)
        notify "Color Utils" "Invalid option selected: $choice"
        ;;
    esac
}

main

# #!/usr/bin/env bash
#
# set -euo pipefail
# set +u
#
# # --- Configuration ---
# APP_NAME="fuzzel-colors"
# THEME_NAME="kanso"
# CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/$APP_NAME"
# ICONS_DIR="$CONFIG_DIR/icons/$THEME_NAME"
#
# mkdir -p "$ICONS_DIR"
#
# FUZZEL_DMENU_BASE_ARGS="--dmenu"
#
# # Colors file path
# # The user can override this by setting the environment variable
# # e.g., COLORS_FILE=/path/to/my/colors.json ./fuzzel-colors.sh
# : "${COLORS_FILE:=$XDG_DATA_HOME/colors/$THEME_NAME.json}"
#
# # --- Helper Functions ---
#
# # Function to send desktop notifications
# notify() {
#     local title="$1"
#     local message="$2"
#     if command -v notify-send &>/dev/null; then
#         notify-send --app-name="$APP_NAME" "$title" "$message"
#     else
#         # Fallback if notify-send is not available
#         echo "Notification: $title - $message" >&2
#     fi
# }
#
# # Function to copy to clipboard
# copy_to_clipboard() {
#     local text="$1"
#     if command -v wl-copy &>/dev/null; then
#         echo -n "$text" | wl-copy
#         return 0
#     elif command -v xclip &>/dev/null; then
#         echo -n "$text" | xclip -selection clipboard
#         return 0
#     else
#         return 1
#     fi
# }
#
# # Function to run fuzzel with given prompt, input data, and optional extra arguments
# # Usage: run_fuzzel "Prompt:" "Input string" "Extra fuzzel args (e.g., -l 5)"
# run_fuzzel() {
#     local prompt="$1"
#     local input_data="$2"
#     local extra_args="${3:-}"
#
#     if [[ -z "$input_data" ]]; then
#         # Use existing stdin pipe if input_data is empty
#         fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
#     else
#         # Echo input_data to fuzzel
#         echo "$input_data" | fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
#     fi
# }
#
# # --- MODIFIED FUNCTION ---
# # Takes the hex code and the full icon path as arguments.
# # This makes it more robust and prevents issues with '#' in filenames.
# function generate_svg_icon() {
#     local color="$1"
#     local icon_path="$2"
#
#     # Create an SVG for the color if it doesn't exist
#     if [ ! -f "$icon_path" ]; then
#         # Ensure the parent directory exists
#         mkdir -p "$(dirname "$icon_path")"
#         cat >"$icon_path" <<EOF
# <svg width="128" height="128" xmlns="http://www.w3.org/2000/svg">
#   <rect width="128" height="128" fill="$color" />
# </svg>
# EOF
#     fi
# }
#
# # --- MODIFIED FUNCTION ---
# # This now uses a recursive jq query to handle arbitrary nesting depth.
# # It outputs lines in the format: "#hexcode\tlevel1 level2 ..."
# parse_colors_from_json() {
#     if [[ ! -f "$COLORS_FILE" ]]; then
#         notify "Color Utils Error" "Colors file not found at $COLORS_FILE"
#         return 1
#     fi
#
#     if ! command -v jq &>/dev/null; then
#         notify "Color Utils Error" "jq is not installed, required to parse JSON colors file."
#         return 1
#     fi
#
#     # Use `paths(scalars)` to get the key path for every final value.
#     # Then, format the output as `value\tpath_keys_joined_by_space`.
#     jq -r '
#         paths(scalars) as $path
#         | getpath($path) as $value
#         | $path | join(" ") as $name
#         | "\($value)\t\($name)"
#     ' "$COLORS_FILE"
# }
#
# # --- Color Utils Actions ---
#
# # Pick color using hyprpicker with format: HEX, RGB, HSL, etc.
# pick_with_hyprpicker() {
#     if ! command -v hyprpicker &>/dev/null; then
#         notify "Color Utils Error" "hyprpicker is not installed"
#         return 1
#     fi
#
#     local format="${1,,}"              # Convert to lowercase, as hyprpicker expects it
#     [[ -z "$format" ]] && format="hex" # Default to hex if empty
#
#     notify "Color Utils" "Click on any pixel to pick its color..."
#
#     local color
#     if color=$(hyprpicker -a -f "$format" 2>/dev/null); then
#         # hyprpicker outputs with # for hex, e.g., "#RRGGBB"
#         if copy_to_clipboard "$color"; then
#             notify "Color Utils" "Picked color ($format): $color (copied to clipboard)"
#         else
#             notify "Color Utils" "Picked color ($format): $color (failed to copy to clipboard)"
#         fi
#     else
#         notify "Color Utils" "Color picking cancelled"
#     fi
# }
#
# # Pick color using niri
# pick_with_niri() {
#     notify "Color Utils" "Click on any pixel to pick its color..."
#
#     local color
#     if color=$(niri msg pick-color 2>/dev/null); then
#         # niri msg pick-color returns format like "sRGB: #RRGGBB"
#         # Extract just the hex code
#         color=$(echo "$color" | grep -oE '#[0-9A-Fa-f]{6}' | head -1)
#
#         if [[ -n "$color" ]]; then
#             if copy_to_clipboard "$color"; then
#                 notify "Color Utils" "Picked color: $color (copied to clipboard)"
#             else
#                 notify "Color Utils" "Picked color: $color (failed to copy to clipboard)"
#             fi
#         else
#             notify "Color Utils Error" "Failed to parse color from niri output"
#         fi
#     else
#         notify "Color Utils" "Color picking cancelled"
#     fi
# }
#
# # Build the color palette
# build_color_palette() {
#     local colors_data
#     if ! colors_data=$(parse_colors_from_json); then
#         return 1
#     fi
#
#     if [[ -z "$colors_data" ]]; then
#         notify "Color Utils" "No colors found in $COLORS_FILE"
#         return 1
#     fi
#
#     # `read -r hex name` now correctly splits the tab-separated output.
#     # `hex` gets the color code, `name` gets the rest of the line (all keys).
#     echo "$colors_data" | while IFS=$'\t' read -r hex name; do
#         if [[ -z "$hex" ]]; then
#             continue
#         fi
#
#         # Sanitize hex code for use in a filename by removing the '#'
#         local filename_hex="${hex#\#}"
#         local icon_path="$ICONS_DIR/$filename_hex.svg"
#
#         # Generate the icon if it doesn't exist, passing the correct path
#         generate_svg_icon "$hex" "$icon_path"
#
#         # Print the entry
#         echo -e "$hex  $name\0icon\x1f$icon_path"
#     done
# }
#
# show_color_palette() {
#     local selected
#     selected=$(build_color_palette | fuzzel --dmenu --prompt="Select color: " -l 10)
#
#     if [[ -n "$selected" ]]; then
#         local hex="${selected%% *}"
#         if copy_to_clipboard "$hex"; then
#             notify "Color Utils" "Copied $hex to clipboard"
#         else
#             notify "Color Utils" "Selected $hex (failed to copy to clipboard)"
#         fi
#     fi
# }
#
# # --- Main Logic ---
#
# main() {
#     local main_menu_options=$(
#         cat <<EOF
# ⊹ Pick Color [Hyprpicker] [HEX]
# ⊹ Pick Color [Hyprpicker] [RGB]
# ⊹ Pick Color [Hyprpicker] [CMYK]
# ⊹ Pick Color [Hyprpicker] [HSL]
# ⊹ Pick Color [Hyprpicker] [HSV]
# ⊹ Pick Color [Niri] [HEX]
# ⊹ Color Palette [${THEME_NAME^}]
# EOF
#     )
#
#     # Calculate the exact number of lines for the main menu
#     local num_main_options=$(echo -e "$main_menu_options" | wc -l)
#     local main_menu_specific_args="-l $num_main_options"
#
#     local choice
#     # Pass the calculated line count to run_fuzzel for the main menu
#     choice=$(run_fuzzel "λ " "$main_menu_options" "$main_menu_specific_args") || exit 0
#
#     case "$choice" in
#     "⊹ Pick Color [Hyprpicker] [HEX]")
#         pick_with_hyprpicker "HEX"
#         ;;
#     "⊹ Pick Color [Hyprpicker] [RGB]")
#         pick_with_hyprpicker "RGB"
#         ;;
#     "⊹ Pick Color [Hyprpicker] [CMYK]")
#         pick_with_hyprpicker "CMYK"
#         ;;
#     "⊹ Pick Color [Hyprpicker] [HSL]")
#         pick_with_hyprpicker "HSL"
#         ;;
#     "⊹ Pick Color [Hyprpicker] [HSV]")
#         pick_with_hyprpicker "HSV"
#         ;;
#     "⊹ Pick Color [Niri] [HEX]")
#         pick_with_niri
#         ;;
#     "⊹ Color Palette [${THEME_NAME^}]")
#         show_color_palette
#         ;;
#     *)
#         notify "Color Utils" "Invalid option selected: $choice"
#         ;;
#     esac
# }
#
# main
