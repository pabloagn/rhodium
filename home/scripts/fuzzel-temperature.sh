#!/usr/bin/env bash

set -euo pipefail

# --- Configuration ---
FUZZEL_DMENU_BASE_ARGS="--dmenu"

# Temperature presets (in Kelvin)
declare -A TEMP_PRESETS=(
    ["Candle (1900K)"]="1900"
    ["Sunset (2300K)"]="2300"
    ["Incandescent (2700K)"]="2700"
    ["Warm White (3000K)"]="3000"
    ["Soft White (3500K)"]="3500"
    ["Neutral (4000K)"]="4000"
    ["Cool White (4500K)"]="4500"
    ["Daylight (5000K)"]="5000"
    ["Bright Daylight (5500K)"]="5500"
    ["Cloudy Sky (6000K)"]="6000"
    ["Blue Sky (6500K)"]="6500"
)

# Brightness levels
declare -A BRIGHTNESS_PRESETS=(
    ["Very Dim (50%)"]="0.5"
    ["Dim (70%)"]="0.7"
    ["Slightly Dim (85%)"]="0.85"
    ["Normal (100%)"]="1.0"
)

# Time-based profiles
declare -A TIME_PROFILES=(
    ["Morning (6AM-9AM)"]="5000:0.95"
    ["Day (9AM-5PM)"]="6500:1.0"
    ["Evening (5PM-9PM)"]="4000:0.9"
    ["Night (9PM-6AM)"]="3000:0.8"
)

# Current temperature file (for persistence)
TEMP_STATE_FILE="/tmp/gammastep-state"

# Determine the best adjustment method for this system
ADJUSTMENT_METHOD=""
detect_adjustment_method() {
    if gammastep -m wayland -p 2>/dev/null | grep -q "Color temperature"; then
        ADJUSTMENT_METHOD="wayland"
    elif gammastep -m drm -p 2>/dev/null | grep -q "Color temperature"; then
        ADJUSTMENT_METHOD="drm"
    else
        ADJUSTMENT_METHOD=""
    fi
}

# --- Helper Functions ---

notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &>/dev/null; then
        notify-send "$title" "$message"
    else
        echo "Notification: $title - $message" >&2
    fi
}

run_fuzzel() {
    local prompt="$1"
    local input_data="$2"
    local extra_args="${3:-}"

    if [[ -z "$input_data" ]]; then
        fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    else
        echo "$input_data" | fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    fi
}

# Check if gammastep is running
is_gammastep_running() {
    pgrep -x gammastep >/dev/null 2>&1
}

# Stop gammastep
stop_gammastep() {
    if is_gammastep_running; then
        pkill -x gammastep
        sleep 0.5
    fi
}

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
    echo "${temp}:${brightness}" >"$TEMP_STATE_FILE"
}

# Apply temperature and brightness
apply_temperature() {
    local temperature="$1"
    local brightness="${2:-1.0}"

    stop_gammastep

    # Apply one-shot temperature change with brightness
    # -P resets existing gamma ramps, -O sets the temperature
    local cmd="gammastep"
    if [[ -n "$ADJUSTMENT_METHOD" ]]; then
        cmd="$cmd -m $ADJUSTMENT_METHOD"
    fi
    
    # Run the command and suppress warnings
    $cmd -P -O "$temperature" -b "$brightness" 2>&1 | grep -v "Warning:" &

    save_temperature_state "$temperature" "$brightness"
    notify "Display Temperature" "Applied ${temperature}K at ${brightness} brightness"
}

# --- Temperature Actions ---

# Select from temperature presets
select_temperature_preset() {
    local formatted_list_array=()
    for preset in "${!TEMP_PRESETS[@]}"; do
        formatted_list_array+=("⊹ $preset")
    done

    # Sort the array for consistent ordering
    IFS=$'\n' sorted=($(sort <<<"${formatted_list_array[*]}"))

    local num_options=${#sorted[@]}
    local menu_lines_arg="-l $num_options"

    local selected
    selected=$(run_fuzzel "Select Temperature: " "$(printf "%s\n" "${sorted[@]}")" "$menu_lines_arg") || return 1
    selected=${selected#⊹ } # Remove the symbol

    local temperature="${TEMP_PRESETS[$selected]}"
    if [[ -n "$temperature" ]]; then
        local current_state=$(get_current_temperature)
        local brightness=$(echo "$current_state" | cut -d':' -f2)
        apply_temperature "$temperature" "$brightness"
    fi
}

# Select brightness level
select_brightness() {
    local formatted_list_array=()
    for preset in "${!BRIGHTNESS_PRESETS[@]}"; do
        formatted_list_array+=("⊹ $preset")
    done

    IFS=$'\n' sorted=($(sort -r <<<"${formatted_list_array[*]}"))

    local num_options=${#sorted[@]}
    local menu_lines_arg="-l $num_options"

    local selected
    selected=$(run_fuzzel "Select Brightness: " "$(printf "%s\n" "${sorted[@]}")" "$menu_lines_arg") || return 1
    selected=${selected#⊹ } # Remove the symbol

    local brightness="${BRIGHTNESS_PRESETS[$selected]}"
    if [[ -n "$brightness" ]]; then
        local current_state=$(get_current_temperature)
        local temperature=$(echo "$current_state" | cut -d':' -f1)
        apply_temperature "$temperature" "$brightness"
    fi
}

# Custom temperature input
custom_temperature() {
    local temp_input
    temp_input=$(echo "" | run_fuzzel "Enter Temperature (1000-10000K): " "" "-l 0") || return 1

    # Validate input
    if ! [[ "$temp_input" =~ ^[0-9]+$ ]] || [ "$temp_input" -lt 1000 ] || [ "$temp_input" -gt 10000 ]; then
        notify "Display Temperature" "Invalid temperature. Please enter a value between 1000 and 10000."
        return 1
    fi

    local current_state=$(get_current_temperature)
    local brightness=$(echo "$current_state" | cut -d':' -f2)
    apply_temperature "$temp_input" "$brightness"
}

# Time-based profiles
select_time_profile() {
    local formatted_list_array=()
    for profile in "${!TIME_PROFILES[@]}"; do
        formatted_list_array+=("⊹ $profile")
    done

    IFS=$'\n' sorted=($(sort <<<"${formatted_list_array[*]}"))

    local num_options=${#sorted[@]}
    local menu_lines_arg="-l $num_options"

    local selected
    selected=$(run_fuzzel "Select Time Profile: " "$(printf "%s\n" "${sorted[@]}")" "$menu_lines_arg") || return 1
    selected=${selected#⊹ } # Remove the symbol

    local settings="${TIME_PROFILES[$selected]}"
    if [[ -n "$settings" ]]; then
        local temperature=$(echo "$settings" | cut -d':' -f1)
        local brightness=$(echo "$settings" | cut -d':' -f2)
        apply_temperature "$temperature" "$brightness"
    fi
}

# Adjust temperature incrementally
adjust_temperature() {
    local direction="$1" # "increase" or "decrease"
    local current_state=$(get_current_temperature)
    local current_temp=$(echo "$current_state" | cut -d':' -f1)
    local brightness=$(echo "$current_state" | cut -d':' -f2)

    local new_temp
    if [[ "$direction" == "increase" ]]; then
        new_temp=$((current_temp + 250))
        [[ $new_temp -gt 10000 ]] && new_temp=10000
    else
        new_temp=$((current_temp - 250))
        [[ $new_temp -lt 1000 ]] && new_temp=1000
    fi

    apply_temperature "$new_temp" "$brightness"
}

# Toggle automatic mode
toggle_auto_mode() {
    if is_gammastep_running; then
        stop_gammastep
        notify "Display Temperature" "Automatic mode disabled"
    else
        # Start gammastep with automatic adjustment
        local cmd="gammastep"
        if [[ -n "$ADJUSTMENT_METHOD" ]]; then
            cmd="$cmd -m $ADJUSTMENT_METHOD"
        fi
        $cmd 2>&1 | grep -v "Warning:" &
        notify "Display Temperature" "Automatic mode enabled (location-based)"
    fi
}

# Reset to default
reset_temperature() {
    stop_gammastep
    # Reset with detected method
    local cmd="gammastep"
    if [[ -n "$ADJUSTMENT_METHOD" ]]; then
        cmd="$cmd -m $ADJUSTMENT_METHOD"
    fi
    $cmd -x 2>&1 | grep -v "Warning:"
    save_temperature_state "6500" "1.0"
    notify "Display Temperature" "Reset to default (6500K, 100% brightness)"
}

# Show current status
show_status() {
    local current_state=$(get_current_temperature)
    local temperature=$(echo "$current_state" | cut -d':' -f1)
    local brightness=$(echo "$current_state" | cut -d':' -f2)
    local brightness_percent=$(awk "BEGIN {print $brightness * 100}")

    local status="Current Settings:\n"
    status+="Temperature: ${temperature}K\n"
    status+="Brightness: ${brightness_percent}%\n"

    if is_gammastep_running; then
        status+="Mode: Automatic"
    else
        status+="Mode: Manual"
    fi

    notify "Display Temperature Status" "$status"
}

# --- Main Menu ---

main_menu() {
    local main_menu_options=$(
        cat <<EOF
⊹ Temperature Presets
⊹ Brightness Control
⊹ Time-Based Profiles
⊹ Custom Temperature
⊹ Increase Temperature (+250K)
⊹ Decrease Temperature (-250K)
⊹ Toggle Automatic Mode
⊹ Reset to Default
⊹ Show Current Status
EOF
    )

    local num_main_options=9
    local main_menu_specific_args="-l $num_main_options"

    local choice
    choice=$(run_fuzzel "Display Temperature: " "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "⊹ Temperature Presets")
        select_temperature_preset
        ;;
    "⊹ Brightness Control")
        select_brightness
        ;;
    "⊹ Time-Based Profiles")
        select_time_profile
        ;;
    "⊹ Custom Temperature")
        custom_temperature
        ;;
    "⊹ Increase Temperature (+250K)")
        adjust_temperature "increase"
        ;;
    "⊹ Decrease Temperature (-250K)")
        adjust_temperature "decrease"
        ;;
    "⊹ Toggle Automatic Mode")
        toggle_auto_mode
        ;;
    "⊹ Reset to Default")
        reset_temperature
        ;;
    "⊹ Show Current Status")
        show_status
        ;;
    *)
        notify "Display Temperature" "Invalid option selected: $choice"
        ;;
    esac
}

# --- Entry Point ---

# Detect the best adjustment method on startup
detect_adjustment_method

# Check if script is called with arguments (for keybind mode)
if [[ $# -gt 0 ]]; then
    case "$1" in
    "increase")
        adjust_temperature "increase"
        ;;
    "decrease")
        adjust_temperature "decrease"
        ;;
    "toggle")
        toggle_auto_mode
        ;;
    "reset")
        reset_temperature
        ;;
    "status")
        show_status
        ;;
    *)
        echo "Usage: $0 [increase|decrease|toggle|reset|status]"
        echo "No arguments: Launch interactive menu"
        exit 1
        ;;
    esac
else
    # Launch interactive menu
    main_menu
fi
