#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-mounts"
APP_TITLE="Rhodium's Mounts Util"
PROMPT="∩: "

FUZZEL_DMENU_BASE_ARGS="--dmenu"
MAX_DYNAMIC_LINES=15

# Mount directories for different device types
MOUNT_BASE="/run/media/$USER"
TEMP_MOUNT="/tmp/fuzzel-mount-$$"

# File manager command
FILE_MANAGER="${FILE_MANAGER:-thunar}"
TERMINAL="${TERMINAL:-kitty}"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# Global options array
options=()

# --- Helper Functions ---
run_fuzzel() {
    local prompt="$1"
    local input_data="$2"
    local extra_args="${3:-}"

    if [[ -z "$input_data" ]]; then
        fuzzel $FUZZEL_DMENU_BASE_ARGS "$extra_args" --prompt "$prompt" --width 100
    else
        echo "$input_data" | fuzzel $FUZZEL_DMENU_BASE_ARGS "$extra_args" --prompt "$prompt" --width 100
    fi
}

# Check if running with proper permissions
check_permissions() {
    if [[ $EUID -eq 0 ]]; then
        notify "$APP_TITLE" "Please run without sudo. Script will request permissions when needed." "critical"
        exit 1
    fi
}

# Get all block devices with detailed info
get_block_devices() {
    lsblk -J -o NAME,SIZE,TYPE,FSTYPE,LABEL,UUID,MOUNTPOINT,MODEL,VENDOR,RM,RO,HOTPLUG,STATE 2>/dev/null || echo "{}"
}

# Parse device info for display
parse_device_info() {
    local json="$1"
    local devices=()

    # Parse JSON and extract relevant devices
    while IFS= read -r line; do
        devices+=("$line")
    done < <(echo "$json" | jq -r '
        .blockdevices[]? | 
        select(.type == "disk" or .type == "part") |
        . as $parent |
        if .children then
            .children[] | 
            select(.type == "part") |
            {
                name: .name,
                size: .size,
                fstype: .fstype,
                label: .label,
                mountpoint: .mountpoint,
                model: ($parent.model // $parent.vendor // "Unknown"),
                removable: ($parent.rm // false),
                readonly: .ro,
                parent: $parent.name
            }
        else
            {
                name: .name,
                size: .size,
                fstype: .fstype,
                label: .label,
                mountpoint: .mountpoint,
                model: (.model // .vendor // "Unknown"),
                removable: (.rm // false),
                readonly: .ro,
                parent: null
            }
        end |
        "\(.name)|\(.size)|\(.fstype // "Unknown")|\(.label // "No Label")|\(.mountpoint // "Not Mounted")|\(.model)|\(.removable)|\(.readonly)|\(.parent // "")"
    ')

    printf "%s\n" "${devices[@]}"
}

# Format device for display
format_device_entry() {
    local name="$1" size="$2" fstype="$3" label="$4" mountpoint="$5"
    local model="$6" removable="$7" readonly="$8" parent="$9"

    local device_desc="/dev/$name"
    [[ -n "$parent" ]] && device_desc="/dev/$name"

    # Truncate long strings to fit columns
    label="${label:0:25}"
    model="${model:0:30}"
    mountpoint="${mountpoint:0:40}"

    # Format: ⊹ LABEL    DEVICE    MODEL    FSTYPE    SIZE    MOUNTPOINT
    printf "⊹ %-25s %-15s %-30s %-8s %-8s %s\n" \
        "$label" \
        "$device_desc" \
        "$model" \
        "$fstype" \
        "$size" \
        "$mountpoint"
}

# --- Storage Actions ---

# List all storage devices
list_devices() {
    local devices_json=$(get_block_devices)
    local device_info=$(parse_device_info "$devices_json")

    if [[ -z "$device_info" ]]; then
        notify "$APP_TITLE" "No storage devices found."
        return 0
    fi

    local formatted_list_array=()
    declare -A device_map

    while IFS='|' read -r name size fstype label mountpoint model removable readonly parent; do
        local entry=$(format_device_entry "$name" "$size" "$fstype" "$label" "$mountpoint" \
            "$model" "$removable" "$readonly" "$parent")
        formatted_list_array+=("$entry")
        device_map["$entry"]="$name|$mountpoint|$fstype|$label|$readonly"
    done <<<"$device_info"

    local num_options=${#formatted_list_array[@]}
    local display_lines=$((num_options < MAX_DYNAMIC_LINES ? num_options : MAX_DYNAMIC_LINES))

    run_fuzzel "Storage Devices: " "$(printf "%s\n" "${formatted_list_array[@]}")" "-l $display_lines" || true
}

# Mount a device
mount_device() {
    local devices_json=$(get_block_devices)
    local device_info=$(parse_device_info "$devices_json")

    local unmounted_devices=()
    declare -A device_map

    while IFS='|' read -r name size fstype label mountpoint model removable readonly parent; do
        if [[ "$mountpoint" == "Not Mounted" ]] && [[ "$fstype" != "Unknown" ]]; then
            local entry=$(format_device_entry "$name" "$size" "$fstype" "$label" "$mountpoint" \
                "$model" "$removable" "$readonly" "$parent")
            unmounted_devices+=("$entry")
            device_map["$entry"]="$name|$fstype|$label"
        fi
    done <<<"$device_info"

    if [[ ${#unmounted_devices[@]} -eq 0 ]]; then
        notify "$APP_TITLE" "No unmounted devices found."
        return 0
    fi

    local selected
    selected=$(run_fuzzel "Mount Device: " "$(printf "%s\n" "${unmounted_devices[@]}")" "-l ${#unmounted_devices[@]}") || return 1

    local device_data="${device_map["$selected"]}"
    IFS='|' read -r device_name fstype label <<<"$device_data"

    notify "$APP_TITLE" "Mounting /dev/$device_name..."

    local mount_result
    if mount_result=$(udisksctl mount -b "/dev/$device_name" 2>&1); then
        # Extract mount point from output like "Mounted /dev/sda1 at /media/user/label."
        local mount_point=$(echo "$mount_result" | sed -n 's/^Mounted .* at \(.*\)\.$/\1/p')

        notify "$APP_TITLE" "Successfully mounted /dev/$device_name at $mount_point"

        # Offer to open in file manager
        local open_choice=$(echo -e "⊹ Open in File Manager\n⊹ Close" | run_fuzzel "Device Mounted: " "" "-l 2")
        if [[ "$open_choice" == "⊹ Open in File Manager" ]]; then
            $FILE_MANAGER "$mount_point" &
        fi
    else
        notify "$APP_TITLE" "Failed to mount /dev/$device_name: $mount_result" "critical"
    fi
}

# Unmount a device
unmount_device() {
    local devices_json=$(get_block_devices)
    local device_info=$(parse_device_info "$devices_json")

    local mounted_devices=()
    declare -A device_map

    while IFS='|' read -r name size fstype label mountpoint model removable readonly parent; do
        if [[ "$mountpoint" != "Not Mounted" ]] && [[ "$mountpoint" != "/" ]] &&
            [[ ! "$mountpoint" =~ ^/(boot|nix|home|var|usr|etc|sys|proc|dev|run/wrappers) ]]; then
            local entry=$(format_device_entry "$name" "$size" "$fstype" "$label" "$mountpoint" \
                "$model" "$removable" "$readonly" "$parent")
            mounted_devices+=("$entry")
            device_map["$entry"]="$name|$mountpoint"
        fi
    done <<<"$device_info"

    if [[ ${#mounted_devices[@]} -eq 0 ]]; then
        notify "$APP_TITLE" "No mounted removable devices found."
        return 0
    fi

    local selected
    selected=$(run_fuzzel "Unmount Device: " "$(printf "%s\n" "${mounted_devices[@]}")" "-l ${#mounted_devices[@]}") || return 1

    local device_data="${device_map["$selected"]}"
    IFS='|' read -r device_name mount_point <<<"$device_data"

    notify "$APP_TITLE" "Unmounting $mount_point..."

    # Use udisksctl instead of umount
    if udisksctl unmount -b "/dev/$device_name" 2>&1; then
        notify "$APP_TITLE" "Successfully unmounted $mount_point"
    else
        # Force unmount if regular fails
        local force_choice=$(echo -e "⊹ Force Unmount\n⊹ Cancel" | run_fuzzel "Device Busy: " "" "-l 2")
        if [[ "$force_choice" == "⊹ Force Unmount" ]]; then
            if udisksctl unmount -f -b "/dev/$device_name" 2>&1; then
                notify "$APP_TITLE" "Force unmounted $mount_point"
            else
                notify "$APP_TITLE" "Failed to unmount $mount_point" "critical"
            fi
        fi
    fi
}

# Explore mounted device
explore_device() {
    local devices_json=$(get_block_devices)
    local device_info=$(parse_device_info "$devices_json")

    local mounted_devices=()
    declare -A device_map

    while IFS='|' read -r name size fstype label mountpoint model removable readonly parent; do
        if [[ "$mountpoint" != "Not Mounted" ]]; then
            local entry=$(format_device_entry "$name" "$size" "$fstype" "$label" "$mountpoint" \
                "$model" "$removable" "$readonly" "$parent")
            mounted_devices+=("$entry")
            device_map["$entry"]="$mountpoint"
        fi
    done <<<"$device_info"

    if [[ ${#mounted_devices[@]} -eq 0 ]]; then
        notify "$APP_TITLE" "No mounted devices found."
        return 0
    fi

    local selected
    selected=$(run_fuzzel "Explore Device: " "$(printf "%s\n" "${mounted_devices[@]}")" "-l ${#mounted_devices[@]}") || return 1

    local mount_point="${device_map["$selected"]}"

    local explore_options=$(
        cat <<EOF
⊹ Open in File Manager
⊹ Open in Terminal
⊹ Show Disk Usage
⊹ Show Properties
EOF
    )

    local action
    action=$(run_fuzzel "Action: " "$explore_options" "-l 4") || return 1

    case "$action" in
    "⊹ Open in File Manager")
        $FILE_MANAGER "$mount_point" &
        ;;
    "⊹ Open in Terminal")
        $TERMINAL -e bash -c "cd '$mount_point' && exec bash" &
        ;;
    "⊹ Show Disk Usage")
        local usage=$(df -h "$mount_point" | tail -1)
        notify "Disk Usage" "$usage"
        ;;
    "⊹ Show Properties")
        show_device_properties "$mount_point"
        ;;
    esac
}

# Show detailed device properties
show_device_properties() {
    local mount_point="$1"
    local properties=$(df -h "$mount_point" | tail -1)
    local device=$(echo "$properties" | awk '{print $1}')

    # Get detailed info
    local info=""
    info+="Device: $device\n"
    info+="Mount Point: $mount_point\n"
    info+=$(echo "$properties" | awk '{print "Size: " $2 "\nUsed: " $3 " (" $5 ")\nAvailable: " $4}')

    # Get filesystem info using udisksctl info instead of blkid
    if command -v udisksctl &>/dev/null; then
        local device_info=$(udisksctl info -b "$device" 2>/dev/null | grep -E "IdLabel:|IdUUID:|IdType:" | sed 's/^ *//')
        if [[ -n "$device_info" ]]; then
            info+="\n\nFilesystem Info:\n$device_info"
        fi
    fi

    notify "Device Properties" "$info"
}

# --- Menu Generation ---
noop() {
    :
}

generate_menu_options() {
    options=()

    options+=("List All Devices:list_devices")
    options+=("Mount Device:mount_device")
    options+=("Unmount Device:unmount_device")
    options+=("Explore Device:explore_device")
    options+=("Refresh Device List:noop")
    options+=("Open Disks Utility:noop")
    options+=("Open Dust:noop")
    options+=("Exit:noop")
}

# --- Main ---

main() {
    check_permissions

    while true; do
        generate_menu_options
        decorate_fuzzel_menu options

        local line_count=$(get_fuzzel_line_count)
        local selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count" -w 100)

        [[ -z "$selected" ]] && exit 0

        if [[ "$selected" =~ ^---.*---$ ]]; then
            continue
        fi

        # Handle special menu items
        case "$selected" in
        "⊹ Exit")
            exit 0
            ;;
        "⊹ Refresh Device List")
            partprobe 2>/dev/null || pkexec partprobe 2>/dev/null || true
            notify "$APP_TITLE" "Device list refreshed"
            continue
            ;;
        "⊹ Open Disks Utility")
            if command -v gnome-disks &>/dev/null; then
                gnome-disks &
            else
                notify "$APP_TITLE" "GNOME Disks not installed. Add package to home manager and rebuild:\n◌ nixos.gnome.gnome-disk-utility"
            fi
            continue
            ;;
        "⊹ Open Dust")
            if command -v dust &>/dev/null; then
                $TERMINAL -e --hold dust &
            else
                notify "$APP_TITLE" "Dust not installed. Add package to home manager and rebuild:\n◌dust"
            fi
            continue
            ;;
        esac

        # Execute mapped commands
        if [[ -n "${menu_commands[$selected]:-}" ]]; then
            eval "${menu_commands[$selected]}"
        else
            notify "$APP_TITLE" "No command associated with selected option: $selected"
        fi
    done
}

main
