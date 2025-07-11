#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "temperature"

# --- Presets Menu Options ---
options=(
    "Coolest (20000K):set_temp_20000"
    "Cooler (12000K):set_temp_12000"
    "Cool (9000K):set_temp_9000"
    "Slightly Cool (7500K):set_temp_7500"
    "Neutral (6500K):set_temp_6500"
    "Slightly Warm (5000K):set_temp_5000"
    "Warm (4000K):set_temp_4000"
    "Warmer (3000K):set_temp_3000"
    "Warmest (1800K):set_temp_1800"
    "Reset:kill_wlsunset"
)

decorate_fuzzel_menu options

# --- Actions ---
run_wlsunset() {
    local temp="$1"
    notify "$APP_TITLE" "Setting temperature to ${temp}K"
    pkill wlsunset || true
    wlsunset -T "$temp" -t "100" -S 00:00 -s 23:59 -d 1 &
}

set_temp_20000() { run_wlsunset 20000; }
set_temp_12000() { run_wlsunset 12000; }
set_temp_9000() { run_wlsunset 9000; }
set_temp_7500() { run_wlsunset 7500; }
set_temp_6500() { run_wlsunset 6500; }
set_temp_5000() { run_wlsunset 5000; }
set_temp_4000() { run_wlsunset 4000; }
set_temp_3000() { run_wlsunset 3000; }
set_temp_1800() { run_wlsunset 1800; }

kill_wlsunset() {
    pkill wlsunset || true
    notify "$APP_TITLE" "Color temperature reset"
}

# --- Main Logic ---
main() {
    local selected
    selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l 10)

    [[ -z "$selected" ]] && return

    if [[ -n "${menu_commands[$selected]:-}" ]]; then
        "${menu_commands[$selected]}"
    fi
}

main
