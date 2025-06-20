#!/usr/bin/env bash

set -euo pipefail

# --- Configuration ---
APP_NAME="fuzzel-colors"
THEME_NAME="kanso"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/$APP_NAME"

: "${COLORS_FILE:=$XDG_DATA_HOME/colors/$THEME_NAME.json}"
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

notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &>/dev/null; then
        notify-send --app-name="$APP_NAME" "$title" "$message"
    else
        echo "Notification: $title - $message" >&2
    fi
}

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
    jq -r '
        paths(scalars) as $p
        | getpath($p) as $v
        | select($v | test("^#[0-9a-fA-F]{3,8}$"))
        | [$v] + $p | @tsv
    ' "$COLORS_FILE"
}

# --- Color Utils Actions ---

pick_with_hyprpicker() {
    if ! command -v hyprpicker &>/dev/null; then
        notify "Color Utils Error" "hyprpicker is not installed"
        return 1
    fi
    local format="${1,,}"
    [[ -z "$format" ]] && format="hex"
    notify "Color Utils" "Click on any pixel to pick its color..."
    local color
    if color=$(hyprpicker -a -f "$format" 2>/dev/null); then
        if copy_to_clipboard "$color"; then notify "Color Utils" "Picked color ($format): <span weight='bold'>$color</span> (copied)"; else notify "Color Utils" "Picked color ($format): $color (failed to copy)"; fi
    else notify "Color Utils" "Color picking cancelled"; fi
}

pick_with_niri() {
    notify "Color Utils" "Click on any pixel to pick its color..."
    local color
    if color=$(niri msg pick-color 2>/dev/null); then
        color=$(echo "$color" | grep -oE '#[0-9A-Fa-f]{6}' | head -1)
        if [[ -n "$color" ]]; then
            if copy_to_clipboard "$color"; then notify "Color Utils" "Picked color: <span weight='bold'>$color</span> (copied)"; else notify "Color Utils" "Picked color: $color (failed to copy)"; fi
        else notify "Color Utils Error" "Failed to parse color from niri output"; fi
    else notify "Color Utils" "Color picking cancelled"; fi
}

show_color_palette() {
    local padding_str="$1"
    local theme_file_name
    theme_file_name=$(basename "$COLORS_FILE" .json)
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

    done < <(parse_colors_from_json)

    if [[ -z "$all_entries" ]]; then
        notify "Color Utils" "No valid colors found in $COLORS_FILE"
        return 0
    fi

    local selected
    selected=$(echo -e "$all_entries" | fuzzel --dmenu --prompt="Select color: ")

    if [[ -n "$selected" ]]; then
        local hex="${selected%% *}"
        if copy_to_clipboard "$hex"; then
            notify "Color Utils" "Copied <span background='$hex' weight='bold'>$hex</span> to clipboard"
        else
            notify "Color Utils" "Selected <span background='$hex' weight='bold'>$hex</span> (failed to copy to clipboard)"
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
        notify "Color Utils Error" "jq is not installed."
        exit 1
    fi
    if [[ ! -f "$COLORS_FILE" ]]; then
        notify "Color Utils Error" "Colors file not found at $COLORS_FILE"
        exit 1
    fi

    local theme_display_name
    theme_display_name=$(basename "$COLORS_FILE" .json)

    local main_menu_options=$(
        cat <<EOF
⊹ Pick Color [Hyprpicker] [HEX]
⊹ Pick Color [Hyprpicker] [RGB]
⊹ Pick Color [Hyprpicker] [CMYK]
⊹ Pick Color [Hyprpicker] [HSL]
⊹ Pick Color [Hyprpicker] [HSV]
⊹ Pick Color [Niri] [HEX]
⊹ Color Palette [${theme_display_name^}]
EOF
    )

    local num_main_options=$(echo -e "$main_menu_options" | wc -l)

    local choice
    choice=$(echo -e "$main_menu_options" | fuzzel --dmenu --prompt="λ " -l "$num_main_options") || exit 0

    case "$choice" in
    "⊹ Pick Color [Hyprpicker] [HEX]") pick_with_hyprpicker "HEX" ;;
    "⊹ Pick Color [Hyprpicker] [RGB]") pick_with_hyprpicker "RGB" ;;
    "⊹ Pick Color [Hyprpicker] [CMYK]") pick_with_hyprpicker "CMYK" ;;
    "⊹ Pick Color [Hyprpicker] [HSL]") pick_with_hyprpicker "HSL" ;;
    "⊹ Pick Color [Hyprpicker] [HSV]") pick_with_hyprpicker "HSV" ;;
    "⊹ Pick Color [Niri] [HEX]") pick_with_niri ;;
    "⊹ Color Palette [${theme_display_name^}]")
        show_color_palette "$PADDING_ARGS"
        ;;
    *)
        notify "Color Utils" "Invalid option selected: $choice"
        ;;
    esac
}

# Pass all script arguments to the main function
main "$@"
