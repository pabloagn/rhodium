#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-colors"
APP_TITLE="Rhodium's Color Utils"
PROMPT="μ: "

FUZZEL_DMENU_BASE_ARGS="--dmenu"
MAX_DYNAMIC_LINES=15

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# USB device state cache
DEVICE_STATE_DIR="/tmp/usb-device-states"
mkdir -p "$DEVICE_STATE_DIR"

# Device categories for quick filters
declare -A DEVICE_CATEGORIES=(
    ["audio"]="Audio|Sound|Microphone|Headset|Speaker"
    ["video"]="Video|Camera|Webcam|Capture"
    ["input"]="Keyboard|Mouse|Touchpad|Controller|Gamepad|Joystick"
    ["storage"]="Storage|Disk|Flash|Card Reader"
    ["network"]="Network|Ethernet|Wi-Fi|Bluetooth"
    ["printer"]="Printer|Scanner"
    ["hub"]="Hub|Dock"
)

# --- Helper Functions ---

notify() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"
    if command -v notify-send &>/dev/null; then
        notify-send -u "$urgency" "$title" "$message"
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

# Get USB device information
get_usb_devices() {
    local category_filter="${1:-}"

    # Get all USB devices with their properties
    for device in /sys/bus/usb/devices/*/; do
        [[ -d "$device" ]] || continue

        # Skip root hubs and interfaces
        local devnum=$(cat "$device/devnum" 2>/dev/null || echo "0")
        [[ "$devnum" == "1" ]] && continue

        # Get device info
        local busnum=$(cat "$device/busnum" 2>/dev/null || echo "")
        local idVendor=$(cat "$device/idVendor" 2>/dev/null || echo "")
        local idProduct=$(cat "$device/idProduct" 2>/dev/null || echo "")
        local manufacturer=$(cat "$device/manufacturer" 2>/dev/null || echo "Unknown")
        local product=$(cat "$device/product" 2>/dev/null || echo "Unknown Device")
        local serial=$(cat "$device/serial" 2>/dev/null || echo "")
        local bDeviceClass=$(cat "$device/bDeviceClass" 2>/dev/null || echo "00")
        local authorized=$(cat "$device/authorized" 2>/dev/null || echo "1")
        local removable=$(cat "$device/removable" 2>/dev/null || echo "unknown")

        # Skip if essential info is missing
        [[ -z "$busnum" || -z "$devnum" ]] && continue

        # Determine device type
        local device_type="Other"
        case "$bDeviceClass" in
        "01") device_type="Audio" ;;
        "03") device_type="HID" ;;
        "08") device_type="Storage" ;;
        "09") device_type="Hub" ;;
        "0e") device_type="Video" ;;
        "e0") device_type="Wireless" ;;
        esac

        # Additional type detection from product name
        if [[ "$product" =~ [Kk]eyboard ]]; then
            device_type="Keyboard"
        elif [[ "$product" =~ [Mm]ouse ]]; then
            device_type="Mouse"
        elif [[ "$product" =~ [Ww]ebcam|[Cc]amera ]]; then
            device_type="Webcam"
        elif [[ "$product" =~ [Mm]icrophone|[Mm]ic ]]; then
            device_type="Microphone"
        elif [[ "$product" =~ [Hh]eadset|[Hh]eadphone ]]; then
            device_type="Audio"
        fi

        # Apply category filter if specified
        if [[ -n "$category_filter" ]]; then
            local pattern="${DEVICE_CATEGORIES[$category_filter]:-$category_filter}"
            if ! [[ "$device_type" =~ $pattern ]] && ! [[ "$product" =~ $pattern ]]; then
                continue
            fi
        fi

        # Output device info
        local device_path=$(basename "$device")
        echo "${device_path}|${busnum}|${devnum}|${idVendor}|${idProduct}|${manufacturer}|${product}|${device_type}|${authorized}|${serial}"
    done | sort -t'|' -k7,7 -k6,6
}

# Get device state (enabled/disabled)
is_device_authorized() {
    local device_path="$1"
    local auth_file="/sys/bus/usb/devices/$device_path/authorized"
    if [[ -f "$auth_file" ]]; then
        local authorized=$(cat "$auth_file" 2>/dev/null || echo "1")
        [[ "$authorized" == "1" ]]
    else
        return 0 # Assume authorized if can't check
    fi
}

# Enable/disable USB device
toggle_device_state() {
    local device_path="$1"
    local action="$2" # "enable" or "disable"
    local auth_file="/sys/bus/usb/devices/$device_path/authorized"

    if [[ ! -f "$auth_file" ]]; then
        notify "USB Manager" "Cannot access device authorization file" "critical"
        return 1
    fi

    local new_state="0"
    [[ "$action" == "enable" ]] && new_state="1"

    # Try to change state
    if echo "$new_state" >"$auth_file" 2>/dev/null || pkexec bash -c "echo '$new_state' > '$auth_file'"; then
        local state_text="disabled"
        [[ "$action" == "enable" ]] && state_text="enabled"
        notify "USB Manager" "Device $state_text successfully"

        # Save state for persistence
        echo "$new_state" >"$DEVICE_STATE_DIR/$device_path" 2>/dev/null || true
        return 0
    else
        notify "USB Manager" "Failed to change device state" "critical"
        return 1
    fi
}

# --- Device Actions ---

# List all USB devices
list_all_devices() {
    local devices=$(get_usb_devices)

    if [[ -z "$devices" ]]; then
        notify "USB Manager" "No USB devices found"
        return 0
    fi

    local formatted_list_array=()
    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
        local status="[Enabled]"
        [[ "$authorized" == "0" ]] && status="[Disabled]"

        local entry="⊹ $product_name - $type $status"
        entry+="\n   └─ $manufacturer (Bus $busnum Dev $devnum)"
        entry+="\n   └─ ID ${vendor}:${product}"
        formatted_list_array+=("$entry")
    done <<<"$devices"

    local num_options=${#formatted_list_array[@]}
    local display_lines=$((num_options < MAX_DYNAMIC_LINES ? num_options : MAX_DYNAMIC_LINES))

    run_fuzzel "USB Devices: " "$(printf "%s\n" "${formatted_list_array[@]}")" "-l $display_lines" || true
}

# Manage device by category
manage_by_category() {
    local categories=$(
        cat <<EOF
⊹ Keyboards
⊹ Mice & Pointing Devices
⊹ Webcams & Cameras
⊹ Microphones & Audio
⊹ Storage Devices
⊹ Network Devices
⊹ Printers & Scanners
⊹ USB Hubs
⊹ All Devices
EOF
    )

    local choice
    choice=$(run_fuzzel "Device Category: " "$categories" "-l 9") || return 1

    local filter=""
    case "$choice" in
    "⊹ Keyboards") filter="Keyboard" ;;
    "⊹ Mice & Pointing Devices") filter="Mouse|Touchpad" ;;
    "⊹ Webcams & Cameras") filter="video" ;;
    "⊹ Microphones & Audio") filter="audio" ;;
    "⊹ Storage Devices") filter="storage" ;;
    "⊹ Network Devices") filter="network" ;;
    "⊹ Printers & Scanners") filter="printer" ;;
    "⊹ USB Hubs") filter="hub" ;;
    "⊹ All Devices") filter="" ;;
    esac

    manage_devices "$filter"
}

# Manage devices (enable/disable)
manage_devices() {
    local filter="$1"
    local devices=$(get_usb_devices "$filter")

    if [[ -z "$devices" ]]; then
        notify "USB Manager" "No devices found in this category"
        return 0
    fi

    local formatted_list_array=()
    declare -A device_map

    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
        local status="✓"
        local status_text="Enabled"
        if [[ "$authorized" == "0" ]]; then
            status="✗"
            status_text="Disabled"
        fi

        local entry="$status $product_name ($type)"
        formatted_list_array+=("$entry")
        device_map["$entry"]="$path|$product_name|$authorized"
    done <<<"$devices"

    local selected
    selected=$(run_fuzzel "Select Device: " "$(printf "%s\n" "${formatted_list_array[@]}")" "-l ${#formatted_list_array[@]}") || return 1

    local device_data="${device_map["$selected"]}"
    IFS='|' read -r device_path product_name authorized <<<"$device_data"

    # Show device actions
    local actions=""
    if [[ "$authorized" == "1" ]]; then
        actions="⊹ Disable Device\n⊹ Device Information"
    else
        actions="⊹ Enable Device\n⊹ Device Information"
    fi

    local action
    action=$(echo -e "$actions" | run_fuzzel "Action for $product_name: " "" "-l 2") || return 1

    case "$action" in
    "⊹ Enable Device")
        toggle_device_state "$device_path" "enable"
        ;;
    "⊹ Disable Device")
        toggle_device_state "$device_path" "disable"
        ;;
    "⊹ Device Information")
        show_device_info "$device_path"
        ;;
    esac
}

# Show detailed device information
show_device_info() {
    local device_path="$1"
    local device_dir="/sys/bus/usb/devices/$device_path"

    if [[ ! -d "$device_dir" ]]; then
        notify "USB Manager" "Device information not available"
        return 1
    fi

    local info="USB Device Information:\n\n"

    # Collect device information
    for attr in product manufacturer serial idVendor idProduct bcdDevice speed maxpower configuration; do
        if [[ -f "$device_dir/$attr" ]]; then
            local value=$(cat "$device_dir/$attr" 2>/dev/null || echo "N/A")
            info+="$(echo "$attr" | sed 's/^./\U&/'): $value\n"
        fi
    done

    # Get driver info
    if [[ -d "$device_dir/driver" ]]; then
        local driver=$(basename "$(readlink "$device_dir/driver" 2>/dev/null)" 2>/dev/null || echo "Unknown")
        info+="Driver: $driver\n"
    fi

    notify "Device Information" "$info"
}

# Quick toggle for common devices
quick_toggle() {
    local common_devices=$(
        cat <<EOF
⊹ Toggle All Webcams
⊹ Toggle All Microphones
⊹ Toggle All Keyboards (Except Primary)
⊹ Toggle All Storage Devices
⊹ Enable All Devices
⊹ Disable Non-Essential Devices
EOF
    )

    local choice
    choice=$(run_fuzzel "Quick Actions: " "$common_devices" "-l 6") || return 1

    case "$choice" in
    "⊹ Toggle All Webcams")
        toggle_device_category "Webcam|Camera"
        ;;
    "⊹ Toggle All Microphones")
        toggle_device_category "Microphone|Mic"
        ;;
    "⊹ Toggle All Keyboards (Except Primary)")
        toggle_keyboards_except_primary
        ;;
    "⊹ Toggle All Storage Devices")
        toggle_device_category "Storage"
        ;;
    "⊹ Enable All Devices")
        enable_all_devices
        ;;
    "⊹ Disable Non-Essential Devices")
        disable_non_essential
        ;;
    esac
}

# Toggle all devices in a category
toggle_device_category() {
    local pattern="$1"
    local devices=$(get_usb_devices)
    local toggled=0

    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
        if [[ "$product_name" =~ $pattern ]] || [[ "$type" =~ $pattern ]]; then
            local new_state="disable"
            [[ "$authorized" == "0" ]] && new_state="enable"

            if toggle_device_state "$path" "$new_state" 2>/dev/null; then
                ((toggled++))
            fi
        fi
    done <<<"$devices"

    notify "USB Manager" "Toggled $toggled devices"
}

# Toggle keyboards except primary
toggle_keyboards_except_primary() {
    local devices=$(get_usb_devices "Keyboard")
    local keyboard_count=0
    local toggled=0

    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
        if [[ "$type" == "Keyboard" ]]; then
            ((keyboard_count++))
            # Skip first keyboard (assume it's primary)
            if [[ $keyboard_count -gt 1 ]]; then
                local new_state="disable"
                [[ "$authorized" == "0" ]] && new_state="enable"

                if toggle_device_state "$path" "$new_state" 2>/dev/null; then
                    ((toggled++))
                fi
            fi
        fi
    done <<<"$devices"

    notify "USB Manager" "Toggled $toggled secondary keyboards"
}

# Enable all devices
enable_all_devices() {
    local devices=$(get_usb_devices)
    local enabled=0

    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
        if [[ "$authorized" == "0" ]]; then
            if toggle_device_state "$path" "enable" 2>/dev/null; then
                ((enabled++))
            fi
        fi
    done <<<"$devices"

    notify "USB Manager" "Enabled $enabled devices"
}

# Disable non-essential devices
disable_non_essential() {
    local devices=$(get_usb_devices)
    local disabled=0

    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
        # Skip essential device types
        if [[ "$type" =~ ^(Hub|Keyboard|Mouse)$ ]] && [[ "$keyboard_count" -le 1 ]]; then
            continue
        fi

        if [[ "$authorized" == "1" ]] && [[ "$type" =~ ^(Webcam|Microphone|Storage)$ ]]; then
            if toggle_device_state "$path" "disable" 2>/dev/null; then
                ((disabled++))
            fi
        fi
    done <<<"$devices"

    notify "USB Manager" "Disabled $disabled non-essential devices"
}

# Export device status for waybar
export_device_status() {
    local status_file="/tmp/usb-device-status.json"
    local devices=$(get_usb_devices)

    # Count devices by type
    local keyboards=0 keyboards_enabled=0
    local webcams=0 webcams_enabled=0
    local microphones=0 microphones_enabled=0

    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
        case "$type" in
        "Keyboard")
            ((keyboards++))
            [[ "$authorized" == "1" ]] && ((keyboards_enabled++))
            ;;
        "Webcam")
            ((webcams++))
            [[ "$authorized" == "1" ]] && ((webcams_enabled++))
            ;;
        "Microphone")
            ((microphones++))
            [[ "$authorized" == "1" ]] && ((microphones_enabled++))
            ;;
        esac
    done <<<"$devices"

    # Generate JSON status
    cat >"$status_file" <<EOF
{
    "keyboards": {
        "total": $keyboards,
        "enabled": $keyboards_enabled
    },
    "webcams": {
        "total": $webcams,
        "enabled": $webcams_enabled
    },
    "microphones": {
        "total": $microphones,
        "enabled": $microphones_enabled
    }
}
EOF
}

# --- Main Menu ---

main() {
    # Check for command line arguments
    if [[ "$#" -gt 0 ]]; then
        case "$1" in
        "--update-status")
            export_device_status
            exit 0
            ;;
        "--help")
            echo "Usage: $0 [--update-status|--help]"
            echo "  --update-status  Update device status and exit"
            echo "  --help          Show this help"
            exit 0
            ;;
        esac
    fi

    # Export status for waybar
    export_device_status

    local main_menu_options=$(
        cat <<EOF
⊹ List All Devices
⊹ Manage by Category
⊹ Quick Toggle Actions
⊹ Enable All Devices
⊹ Privacy Mode (Disable Cameras/Mics)
⊹ Export Device List
⊹ Refresh Device Status
EOF
    )

    local num_main_options=7
    local main_menu_specific_args="-l $num_main_options"

    local choice
    choice=$(run_fuzzel "$PROMPT" "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "⊹ List All Devices")
        list_all_devices
        ;;
    "⊹ Manage by Category")
        manage_by_category
        ;;
    "⊹ Quick Toggle Actions")
        quick_toggle
        ;;
    "⊹ Enable All Devices")
        enable_all_devices
        ;;
    "⊹ Privacy Mode (Disable Cameras/Mics)")
        toggle_device_category "Webcam|Camera|Microphone|Mic"
        ;;
    "⊹ Export Device List")
        local export_file="/tmp/usb-devices-$(date +%Y%m%d-%H%M%S).txt"
        get_usb_devices >"$export_file"
        notify "USB Manager" "Device list exported to $export_file"
        ;;
    "⊹ Refresh Device Status")
        export_device_status
        notify "USB Manager" "Device status refreshed"
        ;;
    *)
        notify "USB Manager" "Invalid option selected: $choice"
        ;;
    esac
}

main
