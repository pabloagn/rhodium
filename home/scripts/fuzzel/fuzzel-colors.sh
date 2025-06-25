#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-colors"
APP_TITLE="Rhodium's Color Utils"
PROMPT="β: "

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Variables ---
THEME_NAME="kanso"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/$APP_NAME"
COLORS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/colors"
# NOTE: This var below is for testing purposes
# COLORS_DIR="/home/pabloagn/dev/rhodium/home/assets/colors"

: "${COLORS_FILE:=$COLORS_DIR/$THEME_NAME.json}"
PADDING_ARGS="15 15"

# --- Helper Functions ---
usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

A color utility script using fuzzel.

Options:
  -f, --file PATH      Path to the JSON color file.
                       (Default: \$XDG_DATA_HOME/colors/$THEME_NAME.json)
  -p, --padding "P P.." A space-separated list of padding widths for columns.
                       (Default: "$PADDING_ARGS")
  -h, --help           Show this help message.
EOF
}

# --- Helper Functions ---
generate_svg_icon() {
    local color="$1"
    local icon_path="$2"
    if [ ! -f "$icon_path" ]; then
        mkdir -p "$(dirname "$icon_path")"
        cat >"$icon_path" <<EOF
<svg width="128" height="128" xmlns="http://www.w3.org/2000/svg">
  <rect width="128" height="128" fill="$color" />
</svg>
EOF
    fi
}

parse_colors_from_json() {
    local colors_file="$1"
    jq -r '
        paths(scalars) as $p
        | getpath($p) as $v
        | select($v | test("^#[0-9a-fA-F]{3,8}$"))
        | [$v] + $p | @tsv
    ' "$colors_file"
}

# --- Color Utils Actions ---
pick_with_hyprpicker() {
    if ! command -v hyprpicker &>/dev/null; then
        notify "$APP_TITLE" "hyprpicker is not installed"
        return 1
    fi
    local format="${1,,}"
    [[ -z "$format" ]] && format="hex"
    notify "$APP_TITLE" "Click on any pixel to pick its color..."
    local color
    if color=$(hyprpicker -a -f "$format" 2>/dev/null); then
        if copy_to_clipboard "$color"; then notify "$APP_TITLE" "Picked color ($format): <span weight='bold'>$color</span> (copied)"; else notify "$APP_TITLE" "Picked color ($format): $color (failed to copy)"; fi
    else notify "$APP_TITLE" "Color picking cancelled"; fi
}

pick_with_niri() {
    notify "$APP_TITLE" "Click on any pixel to pick its color..."
    local color
    if color=$(niri msg pick-color 2>/dev/null); then
        color=$(echo "$color" | grep -oE '#[0-9A-Fa-f]{6}' | head -1)
        if [[ -n "$color" ]]; then
            if copy_to_clipboard "$color"; then notify "$APP_TITLE" "Picked color: <span weight='bold'>$color</span> (copied)"; else notify "$APP_TITLE" "Picked color: $color (failed to copy)"; fi
        else notify "$APP_TITLE" "Failed to parse color from niri output"; fi
    else notify "$APP_TITLE" "Color picking cancelled"; fi
}

get_available_themes() {
    if [[ ! -d "$COLORS_DIR" ]]; then
        notify "$APP_TITLE" "Error: Colors directory not found at $COLORS_DIR"
        return 1
    fi
    
    local themes=""
    for file in "$COLORS_DIR"/*.json; do
        [[ -f "$file" ]] || continue
        local theme_name
        theme_name=$(basename "$file" .json)
        themes+="${theme_name^}\n"
    done
    
    if [[ -z "$themes" ]]; then
        notify "$APP_TITLE" "No theme files found in $COLORS_DIR"
        return 1
    fi
    
    echo -e "$themes"
}

show_theme_selection() {
    local themes
    themes=$(get_available_themes) || return 1
    
    local selected_theme
    selected_theme=$(echo -e "$themes" | fuzzel --dmenu --prompt="Select theme: " -l 2) || return 0
    
    if [[ -n "$selected_theme" ]]; then
        local theme_file="$COLORS_DIR/${selected_theme,,}.json"
        show_color_palette "$PADDING_ARGS" "$theme_file"
    fi
}

show_color_palette() {
    local padding_str="$1"
    local colors_file="${2:-$COLORS_FILE}"
    
    if [[ ! -f "$colors_file" ]]; then
        notify "$APP_TITLE" "Colors file not found at $colors_file"
        return 1
    fi
    
    local theme_file_name
    theme_file_name=$(basename "$colors_file" .json)
    local icons_dir="$CONFIG_DIR/icons/$theme_file_name"
    mkdir -p "$icons_dir"

    local -a paddings
    read -ra paddings <<<"$padding_str"
    local all_entries=""

    while IFS=$'\t' read -ra parts; do
        [[ ${#parts[@]} -eq 0 ]] && continue

        local hex="${parts[0]}"
        local filename_hex="${hex#\#}"
        local icon_path="$icons_dir/$filename_hex.svg"
        generate_svg_icon "$hex" "$icon_path"

        local formatted_text=""
        local num_parts=${#parts[@]}
        local num_paddings=${#paddings[@]}

        for ((i = 0; i < num_parts; i++)); do
            local part="${parts[i]}"

            if ((i < num_paddings)); then
                local pad_to=${paddings[i]}
                formatted_text+=$(printf "%-*s" "$pad_to" "$part")
            else
                formatted_text+="$part"
            fi

            if ((i < num_parts - 1)); then
                formatted_text+=" "
            fi
        done

        all_entries+="${formatted_text}\0icon\x1f${icon_path}\n"

    done < <(parse_colors_from_json "$colors_file")

    if [[ -z "$all_entries" ]]; then
        notify "$APP_TITLE" "No valid colors found in $colors_file"
        return 0
    fi

    local selected
    selected=$(echo -e "$all_entries" | fuzzel --dmenu --prompt="Select color: ")

    if [[ -n "$selected" ]]; then
        local hex="${selected%% *}"
        if copy_to_clipboard "$hex"; then
            notify "$APP_TITLE" "Copied <span background='$hex' weight='bold'>$hex</span> to clipboard"
        else
            notify "$APP_TITLE" "Selected <span background='$hex' weight='bold'>$hex</span> (failed to copy to clipboard)"
        fi
    fi
}

# --- Main Logic ---
main() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
        -f | --file)
            COLORS_FILE="$2"
            shift 2
            ;;
        -p | --padding)
            PADDING_ARGS="$2"
            shift 2
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
        esac
    done

    # Pre-flight checks before showing menu
    if ! command -v jq &>/dev/null; then
        notify "$APP_TITLE" "Error: jq is not installed."
        exit 1
    fi

    local main_menu_options
    main_menu_options=$(
        cat <<EOF
⊹ Pick Color [Hyprpicker] [HEX]
⊹ Pick Color [Hyprpicker] [RGB]
⊹ Pick Color [Hyprpicker] [CMYK]
⊹ Pick Color [Hyprpicker] [HSL]
⊹ Pick Color [Hyprpicker] [HSV]
⊹ Pick Color [Niri] [HEX]
⊹ Color Palettes
EOF
    )

    local num_main_options
    num_main_options=$(echo -e "$main_menu_options" | wc -l)

    local choice
    choice=$(echo -e "$main_menu_options" | fuzzel --dmenu --prompt="$PROMPT" -l "$num_main_options") || exit 0

    case "$choice" in
    "⊹ Pick Color [Hyprpicker] [HEX]") pick_with_hyprpicker "HEX" ;;
    "⊹ Pick Color [Hyprpicker] [RGB]") pick_with_hyprpicker "RGB" ;;
    "⊹ Pick Color [Hyprpicker] [CMYK]") pick_with_hyprpicker "CMYK" ;;
    "⊹ Pick Color [Hyprpicker] [HSL]") pick_with_hyprpicker "HSL" ;;
    "⊹ Pick Color [Hyprpicker] [HSV]") pick_with_hyprpicker "HSV" ;;
    "⊹ Pick Color [Niri] [HEX]") pick_with_niri ;;
    "⊹ Color Palettes") show_theme_selection ;;
    *)
        notify "$APP_TITLE" "Invalid option selected: $choice"
        ;;
    esac
}

# Pass all script arguments to the main function
main "$@"
