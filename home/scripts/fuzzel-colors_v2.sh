#!/usr/bin/env bash

set -euo pipefail
set +u

# --- Configuration ---
APP_NAME="fuzzel-colors"
NOTIFY="notify-desktop --app-name=$APP_NAME"

# Set up the storage directory and file
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/$APP_NAME"
ICONS_DIR="$CONFIG_DIR/icons"

# Create directories and history if they don't exist
mkdir -p "$ICONS_DIR"

# ------------------------------------------------------------------------------------

# Fuzzel base dmenu arguments. These apply to all fuzzel invocations unless overridden.
FUZZEL_DMENU_BASE_ARGS="--dmenu"

# Maximum number of lines for dynamic lists
MAX_DYNAMIC_LINES=20

# Colors file path
COLORS_FILE="$HOME/dev/rhodium/home/assets/colors/colors-kanso.json"

# --- Helper Functions ---

# Function to send desktop notifications
notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &>/dev/null; then
        notify-send "$title" "$message"
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

# TODO: Testing
function generate_svg_icon() {
    local color="$1"
    local icon_path="$ICONS_DIR/$color.svg"

    # Create an SVG for the color if it doesn't exist
    if [ ! -f "$icon_path" ]; then
        cat >"$icon_path" <<EOF
<svg width="128" height="128" xmlns="http://www.w3.org/2000/svg">
  <rect width="128" height="128" fill="$color" />
</svg>
EOF
    fi
}

# Function to parse colors from the JSON file
parse_colors_from_json() {
    if [[ ! -f "$COLORS_FILE" ]]; then
        notify "Color Utils Error" "Colors file not found at $COLORS_FILE"
        return 1
    fi

    if ! command -v jq &>/dev/null; then
        notify "Color Utils Error" "jq is not installed, required to parse JSON colors file."
        return 1
    fi

    # jq -r 'to_entries[] | "\(.key):\(.value)"' "$COLORS_FILE"
    jq -r 'to_entries[] | "\(.value)"' "$COLORS_FILE"
}

# Function to create color box using ANSI escape codes for fuzzel
create_color_entry() {
    local name="$1"
    local hex="$2"

    # Convert hex to RGB
    local r=$((16#${hex:1:2}))
    local g=$((16#${hex:3:2}))
    local b=$((16#${hex:5:2}))

    # Create a colored block using ANSI escape codes
    # Format: [colored block] colorName (hex)
    printf "\033[48;2;%d;%d;%dm    \033[0m %s (%s)" "$r" "$g" "$b" "$name" "$hex"
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
        notify "Color Utils" "Picked color ($format): $color"
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

# Show color palette from file
build_color_palette() {
    local colors_data
    if ! colors_data=$(parse_colors_from_json); then
        return 1
    fi

    if [[ -z "$colors_data" ]]; then
        notify "Color Utils" "No colors found in $COLORS_FILE"
        return 1
    fi

    while read -r color; do
        if [ ! -e "$ICONS_DIR/$color.svg" ]; then
            generate_svg_icon "$color"
        fi
        echo -e "#$color\0icon\x1f$ICONS_DIR/$color.svg"
    done <"$colors_data"
}

show_color_palette() {
    local selected
    selected=$(build_color_palette | fuzzel --dmenu --prompt="Select color: " -l 10)

    if [[ -n "$hex_code" ]]; then
        if copy_to_clipboard "$hex_code"; then
            notify "Color Utils" "Copied $hex_code to clipboard"
        else
            notify "Color Utils" "Selected $hex_code (failed to copy to clipboard)"
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
⊹ Color Palette [Kanso]
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
    "⊹ Color Palette [Kanso]")
        show_color_palette
        ;;
    *)
        notify "Color Utils" "Invalid option selected: $choice"
        ;;
    esac
}

# main
show_color_palette
