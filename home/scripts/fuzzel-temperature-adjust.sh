#!/usr/bin/env bash

# Helper script for keybind temperature adjustment

set -euo pipefail

TEMP_STATE_FILE="/tmp/niri-temperature-state"
DIRECTION="${1:-increase}"

# Get current temperature from state file
get_current_temperature() {
    if [[ -f "$TEMP_STATE_FILE" ]]; then
        cat "$TEMP_STATE_FILE" 2>/dev/null || echo "6500:1.0"
    else
        echo "6500:1.0"
    fi
}

# Save current temperature to state file
save_temperature_state() {
    local temp="$1"
    local brightness="$2"
    echo "${temp}:${brightness}" > "$TEMP_STATE_FILE"
}

# Main adjustment logic
current_state=$(get_current_temperature)
current_temp=$(echo "$current_state" | cut -d':' -f1)
brightness=$(echo "$current_state" | cut -d':' -f2)

if [[ "$DIRECTION" == "increase" ]]; then
    new_temp=$((current_temp + 250))
    [[ $new_temp -gt 10000 ]] && new_temp=10000
else
    new_temp=$((current_temp - 250))
    [[ $new_temp -lt 1000 ]] && new_temp=1000
fi

# Apply the new temperature
pkill -x redshift 2>/dev/null || true
sleep 0.1
redshift -P -O "$new_temp" -b "$brightness" &

save_temperature_state "$new_temp" "$brightness"

# Show OSD notification if available
if command -v notify-send &>/dev/null; then
    notify-send -t 1000 "Display Temperature" "${new_temp}K"
fi
