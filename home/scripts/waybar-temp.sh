#!/usr/bin/env bash

# Temperature state file
TEMP_STATE_FILE="/tmp/gammastep-current-temp"

# Initialize if needed
if [[ ! -f "$TEMP_STATE_FILE" ]]; then
    echo "6500" > "$TEMP_STATE_FILE"
fi

# Read temperature
temp=$(cat "$TEMP_STATE_FILE" 2>/dev/null || echo "6500")

# Output for waybar
echo "$temp"
