#!/usr/bin/env bash

set -euo pipefail

# Temperature state file
TEMP_STATE_FILE="/tmp/gammastep-current-temp"

# Initialize with neutral temperature if file doesn't exist
if [[ ! -f "$TEMP_STATE_FILE" ]]; then
    echo "6500" > "$TEMP_STATE_FILE"
fi

# Temperature steps (in Kelvin)
TEMP_STEPS=(
    "1000"
    "1500"
    "2000"
    "2500"
    "3000"
    "3500"
    "4000"
    "4500"
    "5000"
    "5500"
    "6000"
    "6500"
    "7000"
    "7500"
    "8000"
    "8500"
    "9000"
    "9500"
    "10000"
)

# Temperature presets
declare -A TEMP_PRESETS=(
    ["Night"]="3000"
    ["Evening"]="4000"
    ["Reading"]="4500"
    ["Day"]="5500"
    ["Cloudy"]="6000"
    ["Neutral"]="6500"
    ["Bright"]="7500"
)

# Apply temperature
apply_temperature() {
    local temp="$1"
    
    # Apply temperature
    gammastep -O "$temp" 2>/dev/null
    
    # Save to state file
    echo "$temp" > "$TEMP_STATE_FILE"
}

# Select from temperature list
select_from_list() {
    local options=""
    for temp in "${TEMP_STEPS[@]}"; do
        options+="⬢ ${temp}K\n"
    done
    
    local selected
    selected=$(echo -e "$options" | fuzzel --dmenu -l 10 -p "Select Temperature: ") || return 1
    
    # Extract temperature value
    local temp=$(echo "$selected" | sed 's/⬢ //g' | sed 's/K//g')
    
    if [[ -n "$temp" ]]; then
        apply_temperature "$temp"
    fi
}

# Select from presets
select_from_preset() {
    local options=""
    for preset in "${!TEMP_PRESETS[@]}"; do
        local temp="${TEMP_PRESETS[$preset]}"
        options+="◐ $preset (${temp}K)\n"
    done
    
    local selected
    selected=$(echo -e "$options" | sort | fuzzel --dmenu -l 7 -p "Select Preset: ") || return 1
    
    # Extract preset name
    local preset_name=$(echo "$selected" | sed 's/◐ //' | cut -d' ' -f1)
    
    if [[ -n "$preset_name" ]] && [[ -n "${TEMP_PRESETS[$preset_name]}" ]]; then
        apply_temperature "${TEMP_PRESETS[$preset_name]}"
    fi
}

# Manual temperature input
manual_temperature() {
    local temp_input
    temp_input=$(echo "" | fuzzel --dmenu -l 0 -p "Enter Temperature (1000-25000K): ") || return 1
    
    # Validate input
    if ! [[ "$temp_input" =~ ^[0-9]+$ ]] || [ "$temp_input" -lt 1000 ] || [ "$temp_input" -gt 25000 ]; then
        exit 1
    fi
    
    apply_temperature "$temp_input"
}

# Reset to neutral
reset_temperature() {
    apply_temperature "6500"
}

# Main menu
main_menu() {
    local options="⬢ Select from List\n◐ Select from Preset\n⌨ Enter Temperature\n○ Reset to Neutral"
    
    local choice
    choice=$(echo -e "$options" | fuzzel --dmenu -l 4 -p "Temperature Control: ") || exit 0
    
    case "$choice" in
        "⬢ Select from List")
            select_from_list
            ;;
        "◐ Select from Preset")
            select_from_preset
            ;;
        "⌨ Enter Temperature")
            manual_temperature
            ;;
        "○ Reset to Neutral")
            reset_temperature
            ;;
    esac
}

# Run main menu
main_menu
