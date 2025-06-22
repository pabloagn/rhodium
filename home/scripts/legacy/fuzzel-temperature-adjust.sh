#!/usr/bin/env bash

set -euo pipefail

# Temperature state file
TEMP_STATE_FILE="/tmp/gammastep-current-temp"

# Initialize with neutral temperature if file doesn't exist
if [[ ! -f "$TEMP_STATE_FILE" ]]; then
    echo "6500" > "$TEMP_STATE_FILE"
fi

# Get current temperature
get_current_temp() {
    cat "$TEMP_STATE_FILE" 2>/dev/null || echo "6500"
}

# Apply temperature
apply_temperature() {
    local temp="$1"
    
    # Apply temperature
    gammastep -O "$temp" 2>/dev/null
    
    # Save to state file
    echo "$temp" > "$TEMP_STATE_FILE"
}

# Adjust temperature
adjust_temperature() {
    local direction="$1"
    local current_temp=$(get_current_temp)
    local new_temp
    
    if [[ "$direction" == "increase" ]]; then
        new_temp=$((current_temp + 500))
        [[ $new_temp -gt 25000 ]] && new_temp=25000
    elif [[ "$direction" == "decrease" ]]; then
        new_temp=$((current_temp - 500))
        [[ $new_temp -lt 1000 ]] && new_temp=1000
    else
        echo "Usage: $0 [increase|decrease]"
        exit 1
    fi
    
    apply_temperature "$new_temp"
}

# Check argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 [increase|decrease]"
    exit 1
fi

adjust_temperature "$1"
