#!/usr/bin/env bash

set -euo pipefail

# --- Configuration ---
# Fuzzel base dmenu arguments. These apply to all fuzzel invocations unless overridden.
FUZZEL_DMENU_BASE_ARGS="--dmenu"

# Maximum number of lines for dynamic lists
MAX_DYNAMIC_LINES=20

# TODO: The color menu is broken. Fix the parsing.
# TODO: Make this right. We need to work on the symlinks
# Colors file path
COLORS_FILE="$HOME/dev/rhodium/home/assets/colors/colors-kanso.nix"

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

# Function to parse colors from the Nix file
parse_colors_from_nix() {
    if [[ ! -f "$COLORS_FILE" ]]; then
        notify "Color Utils Error" "Colors file not found at $COLORS_FILE"
        return 1
    fi

    # Parse the Nix file to extract color definitions
    # This regex matches lines like: colorName = "#HEXCODE";
    grep -E '^\s*[a-zA-Z0-9_]+\s*=\s*"#[0-9A-Fa-f]{6}"' "$COLORS_FILE" |
        sed -E 's/^\s*([a-zA-Z0-9_]+)\s*=\s*"(#[0-9A-Fa-f]{6})".*/\1:\2/'
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

# Pick color using hyprpicker
pick_with_hyprpicker() {
    if ! command -v hyprpicker &>/dev/null; then
        notify "Color Utils Error" "hyprpicker is not installed"
        return 1
    fi

    notify "Color Utils" "Click on any pixel to pick its color..."

    local color
    if color=$(hyprpicker -a 2>/dev/null); then
        # hyprpicker with -a flag auto-copies, but let's ensure it's in our format
        notify "Color Utils" "Picked color: $color (copied to clipboard)"
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
show_color_palette() {
    local colors_data
    if ! colors_data=$(parse_colors_from_nix); then
        return 1
    fi

    if [[ -z "$colors_data" ]]; then
        notify "Color Utils" "No colors found in $COLORS_FILE"
        return 1
    fi

    # Create formatted color entries
    local formatted_entries=""
    while IFS=':' read -r name hex; do
        if [[ -n "$name" && -n "$hex" ]]; then
            formatted_entries+="$(create_color_entry "$name" "$hex")"$'\n'
        fi
    done <<<"$colors_data"

    # Remove trailing newline
    formatted_entries="${formatted_entries%$'\n'}"

    # Count number of colors
    local num_colors=$(echo -e "$formatted_entries" | wc -l)
    local display_lines=$((num_colors < MAX_DYNAMIC_LINES ? num_colors : MAX_DYNAMIC_LINES))

    # Show the palette
    local selected
    if selected=$(run_fuzzel "Select color: " "$formatted_entries" "-l $display_lines"); then
        # Extract hex code from selection (it's in parentheses)
        local hex_code=$(echo "$selected" | grep -oE '#[0-9A-Fa-f]{6}' | tail -1)

        if [[ -n "$hex_code" ]]; then
            if copy_to_clipboard "$hex_code"; then
                notify "Color Utils" "Copied $hex_code to clipboard"
            else
                notify "Color Utils" "Selected $hex_code (failed to copy to clipboard)"
            fi
        fi
    fi
}

# --- Main Logic ---

main() {
    local main_menu_options=$(
        cat <<EOF
⊹ Pick Color (Hyprpicker)
⊹ Pick Color (Niri)
⊹ Color Palette
EOF
    )

    # Calculate the exact number of lines for the main menu
    local num_main_options=$(echo -e "$main_menu_options" | wc -l)
    local main_menu_specific_args="-l $num_main_options"

    local choice
    # Pass the calculated line count to run_fuzzel for the main menu
    choice=$(run_fuzzel "λ " "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "⊹ Pick Color (Hyprpicker)")
        pick_with_hyprpicker
        ;;
    "⊹ Pick Color (Niri)")
        pick_with_niri
        ;;
    "⊹ Color Palette")
        show_color_palette
        ;;
    *)
        notify "Color Utils" "Invalid option selected: $choice"
        ;;
    esac
}

main
