#!/usr/bin/env bash

set -euo pipefail

APP_NAME="rhodium-display"
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
    wl-mirror --fullscreen-output "$target_output" "$source_output" & disown
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

noop() {
    :
}

generate_menu_options() {
    options=()

    local niri_outputs
    if ! niri_outputs=$(get_display_info); then
        options+=("No displays detected:noop")
        options+=("Exit:noop")
        echo "DEBUG: get_display_info failed, populating fallback options." >&2
        return
    fi

    local output_names_str
    output_names_str=$(echo "$niri_outputs" | jq -r 'keys[]' 2>/dev/null || true)
    local output_names=($output_names_str)

    echo "DEBUG: Detected output_names: '${output_names[@]}'" >&2
    declare -A output_status

    if [[ ${#output_names[@]} -eq 0 ]]; then
        notify "$APP_TITLE" "No display names retrieved from Niri output. Check jq parsing or Niri JSON."
        options+=("No displays detected:noop")
        options+=("Exit:noop")
        echo "DEBUG: No output_names detected, populating fallback options." >&2
        return
    fi

    for output_name in "${output_names[@]}"; do
        if echo "$niri_outputs" | jq -e ".\"$output_name\".logical != null" >/dev/null; then
            output_status[$output_name]="on"
            options+=("Turn Off ${output_name}:wlr_randr_off ${output_name}")
            echo "DEBUG: Added 'Turn Off ${output_name}'" >&2
        else
            output_status[$output_name]="off"
            options+=("Turn On ${output_name}:wlr_randr_on ${output_name}")
            echo "DEBUG: Added 'Turn On ${output_name}'" >&2
        fi
    done

    local active_outputs=()
    for output_name in "${output_names[@]}"; do
        if [[ "${output_status[$output_name]}" == "on" ]]; then
            active_outputs+=("$output_name")
            echo "DEBUG: Active output: ${output_name}" >&2
        fi
    done

    if [[ ${#active_outputs[@]} -ge 2 ]]; then
        echo "DEBUG: Preparing mirror options for active outputs: ${active_outputs[@]}" >&2
        for source_output in "${active_outputs[@]}"; do
            for target_output in "${active_outputs[@]}"; do
                if [[ "$source_output" != "$target_output" ]]; then
                    options+=("Mirror ${source_output} to ${target_output}:wl_mirror_outputs ${source_output} ${target_output}")
                    echo "DEBUG: Added 'Mirror ${source_output} to ${target_output}'" >&2
                fi
            done
        done
        options+=("Stop All Mirrors:stop_all_mirrors")
        echo "DEBUG: Added 'Stop All Mirrors'" >&2
    else
        echo "DEBUG: Not enough active displays (${#active_outputs[@]}) for mirroring options." >&2
    fi

    options+=("Exit:noop")
    echo "DEBUG: Final 'options' array contains ${#options[@]} items." >&2
    for item in "${options[@]}"; do
        echo "DEBUG:   - option: $item" >&2
    done
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

    # --- CRITICAL REORDERING ---
    # First, populate 'menu_labels' from 'options'
    decorate_fuzzel_menu options
    echo "DEBUG: After decorate_fuzzel_menu, 'menu_labels' array has ${#menu_labels[@]} entries." >&2
    echo "DEBUG: menu_labels for fuzzel: '${menu_labels[@]}'" >&2

    # Now that 'menu_labels' is populated, call get_fuzzel_line_count
    local line_count
    line_count=$(get_fuzzel_line_count)
    echo "DEBUG: Fuzzel line count (from get_fuzzel_line_count): $line_count" >&2
    # --- END CRITICAL REORDERING ---

    local selected
    selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count")
    echo "DEBUG: Fuzzel selected: '$selected'" >&2

    [[ -z "$selected" ]] && return

    if [[ "$selected" =~ ^---.*---$ ]]; then
        echo "DEBUG: Selected separator, re-running main." >&2
        main
        return
    fi

    if [[ -n "${menu_commands[$selected]:-}" ]]; then
        echo "DEBUG: Executing command for '$selected': '${menu_commands[$selected]}'" >&2
        eval "${menu_commands[$selected]}"
    else
        echo "DEBUG: No command found for '$selected'." >&2
        notify "$APP_TITLE" "No command associated with selected option: $selected"
    fi
}

main
