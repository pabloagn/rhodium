#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-display"
APP_TITLE="Rhodium's Display Menu"
PROMPT="δ: "

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

options=()

get_display_info() {
    local niri_output_json
    if ! niri_output_json=$(niri msg -j outputs 2>/dev/null); then
        echo "DEBUG: 'niri msg -j outputs' command failed or Niri is not running." >&2
        notify "$APP_TITLE" "Error: Niri IPC command failed. Is Niri running?"
        return 1 # Indicate failure
    fi
    echo "DEBUG: Raw niri_outputs: '$niri_output_json'" >&2
    echo "$niri_output_json"
}

wlr_randr_off() {
    local output_name="$1"
    notify "$APP_TITLE" "Turning off display: ${output_name}..."
    if ! wlr-randr --output "$output_name" --off; then
        notify "$APP_TITLE" "Error turning off ${output_name}. Please check if the display is valid or wlr-randr encountered an issue."
        return 1
    fi
    notify "$APP_TITLE" "${output_name} turned off."
}

wlr_randr_on() {
    local output_name="$1"
    notify "$APP_TITLE" "Turning on display: ${output_name}..."
    if ! wlr-randr --output "$output_name" --on; then
        notify "$APP_TITLE" "Error turning on ${output_name}. Please check if the display is valid or wlr-randr encountered an issue."
        return 1
    fi
    notify "$APP_TITLE" "${output_name} turned on."
}

wl_mirror_outputs() {
    local source_output="$1"
    local target_output="$2"

    notify "$APP_TITLE" "Mirroring ${source_output} to ${target_output}..."
    wl-mirror --fullscreen-output "$target_output" "$source_output" &
    disown
    notify "$APP_TITLE" "Mirroring initiated. Check ${target_output} for the mirrored view."
}

stop_all_mirrors() {
    notify "$APP_TITLE" "Stopping all mirror processes..."
    if pgrep -f "wl-mirror" >/dev/null; then
        pkill -f "wl-mirror"
        notify "$APP_TITLE" "All mirror processes stopped."
    else
        notify "$APP_TITLE" "No active mirror processes found."
    fi
}

switch_wallpaper() {
    local target_dir="/var/tmp/current-wallpaper"
    # Use the same APP_NAME defined at the top of your script
    local CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
    local CACHE_FILE="$CACHE_DIR/wallpapers.cache"

    # First, check if the cache file actually exists.
    if [[ ! -f "$CACHE_FILE" ]]; then
        notify "$APP_TITLE" "Wallpaper cache not found!" "Please run the cache builder script."
        return 1
    fi

    while true; do
        local selected_line
        selected_line=$(cut -d$'\t' -f1 "$CACHE_FILE" | fuzzel --dmenu -p "$PROMPT" -l 10 -w 85)

        if [[ -z "${selected_line:-}" ]]; then
            echo "No selection, exiting wallpaper menu."
            break
        fi

        local wallpaper_path
        wallpaper_path=$(awk -F'\t' -v sel="$selected_line" '$1 == sel { print $2; exit }' "$CACHE_FILE")

        if [[ -n "$wallpaper_path" && -f "$wallpaper_path" ]]; then
            ln -sf "$wallpaper_path" "$target_dir"
            notify-send --app-name=rh-utils "Rhodium Utils" "Setting wallpaper: $(basename "$wallpaper_path")"

            niri msg action do-screen-transition --delay-ms 400
            systemctl --user restart rh-swaybg.service
        else
            notify "$APP_TITLE" "Could not find file path for selection."
        fi
    done
}

noop() {
    :
}

generate_menu_options() {
    options=()

    local niri_outputs
    if ! niri_outputs=$(get_display_info); then
        options+=("No displays detected:noop")
        options+=("Exit:noop")
        return
    fi

    local output_names_str
    output_names_str=$(echo "$niri_outputs" | jq -r 'keys[]' 2>/dev/null || true)
    local output_names=($output_names_str)

    declare -A output_status

    if [[ ${#output_names[@]} -eq 0 ]]; then
        notify "$APP_TITLE" "No display names retrieved from Niri output. Check jq parsing or Niri JSON."
        options+=("No displays detected:noop")
        options+=("Exit:noop")
        return
    fi

    for output_name in "${output_names[@]}"; do
        if echo "$niri_outputs" | jq -e ".\"$output_name\".logical != null" >/dev/null; then
            output_status[$output_name]="on"
            options+=("Turn Off ${output_name}:wlr_randr_off ${output_name}")
        else
            output_status[$output_name]="off"
            options+=("Turn On ${output_name}:wlr_randr_on ${output_name}")
        fi
    done

    local active_outputs=()
    for output_name in "${output_names[@]}"; do
        if [[ "${output_status[$output_name]}" == "on" ]]; then
            active_outputs+=("$output_name")
        fi
    done

    if [[ ${#active_outputs[@]} -ge 2 ]]; then
        for source_output in "${active_outputs[@]}"; do
            for target_output in "${active_outputs[@]}"; do
                if [[ "$source_output" != "$target_output" ]]; then
                    options+=("Mirror ${source_output} to ${target_output}:wl_mirror_outputs ${source_output} ${target_output}")
                fi
            done
        done
        options+=("Stop All Mirrors:stop_all_mirrors")
    else
        echo "DEBUG: Not enough active displays (${#active_outputs[@]}) for mirroring options." >&2
    fi

    options+=("Switch Wallpapers:switch_wallpaper")
    options+=("Exit:noop")
}

main() {
    if ! command -v jq &>/dev/null; then
        notify "$APP_TITLE" "Error: jq is not installed. Please install jq to use this script."
        exit 1
    fi
    if ! command -v wlr-randr &>/dev/null; then
        notify "$APP_TITLE" "Error: wlr-randr is not installed. Please install wlr-randr to use this script."
        exit 1
    fi
    if ! command -v wl-mirror &>/dev/null; then
        notify "$APP_TITLE" "Error: wl-mirror is not installed. Please install wl-mirror to use this script."
        exit 1
    fi

    generate_menu_options
    echo "DEBUG: After generate_menu_options, 'options' array has ${#options[@]} entries." >&2

    decorate_fuzzel_menu options

    # Now that 'menu_labels' is populated, call get_fuzzel_line_count
    local line_count
    line_count=$(get_fuzzel_line_count)

    local selected
    selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count")

    [[ -z "$selected" ]] && return

    if [[ "$selected" =~ ^---.*---$ ]]; then
        main
        return
    fi

    if [[ -n "${menu_commands[$selected]:-}" ]]; then
        eval "${menu_commands[$selected]}"
    else
        notify "$APP_TITLE" "No command associated with selected option: $selected"
    fi
}

main
