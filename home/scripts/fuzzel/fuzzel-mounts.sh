#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-launcher"
APP_TITLE="Rhodium's App Launcher"
PROMPT="λ: "

FUZZEL_DMENU_BASE_ARGS="--dmenu"
MAX_DYNAMIC_LINES=15

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# Mount directories for different device types
MOUNT_BASE="/run/media/$USER"
TEMP_MOUNT="/tmp/fuzzel-mount-$$"

# File manager command (adjust based on your preference)
FILE_MANAGER="${FILE_MANAGER:-thunar}"
TERMINAL="${TERMINAL:-kitty}"

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

# Check if running with proper permissions
check_permissions() {
    if [[ $EUID -eq 0 ]]; then
        notify "Storage Manager" "Please run without sudo. Script will request permissions when needed." "critical"
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

    local icon="⊹"
    [[ "$removable" == "true" ]] && icon="⊹"
    [[ "$mountpoint" != "Not Mounted" ]] && icon="⊹"

    local ro_indicator=""
    [[ "$readonly" == "true" ]] && ro_indicator=" [RO]"

    local device_desc="/dev/$name"
    [[ -n "$parent" ]] && device_desc="/dev/$name (on $parent)"

    echo "$icon $label - $device_desc"
    echo "   └─ $fstype, $size, $model$ro_indicator"
    echo "   └─ $mountpoint"
}

# --- Storage Actions ---

# List all storage devices
list_devices() {
    local devices_json=$(get_block_devices)
    local device_info=$(parse_device_info "$devices_json")

    if [[ -z "$device_info" ]]; then
        notify "Storage Manager" "No storage devices found."
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
        notify "Storage Manager" "No unmounted devices found."
        return 0
    fi

    local selected
    selected=$(run_fuzzel "Mount Device: " "$(printf "%s\n" "${unmounted_devices[@]}")" "-l ${#unmounted_devices[@]}") || return 1

    local device_data="${device_map["$selected"]}"
    IFS='|' read -r device_name fstype label <<<"$device_data"

    # Create mount point
    local mount_point="$MOUNT_BASE"
    if [[ -n "$label" ]] && [[ "$label" != "No Label" ]]; then
        mount_point="$MOUNT_BASE/$label"
    else
        mount_point="$MOUNT_BASE/$device_name"
    fi

    notify "Storage Manager" "Mounting /dev/$device_name to $mount_point..."

    # Create mount directory
    mkdir -p "$mount_point" 2>/dev/null || {
        # If regular mkdir fails, try with sudo
        pkexec mkdir -p "$mount_point"
    }

    # Mount the device
    if pkexec mount "/dev/$device_name" "$mount_point"; then
        notify "Storage Manager" "Successfully mounted /dev/$device_name to $mount_point"

        # Offer to open in file manager
        local open_choice=$(echo -e "⊹ Open in File Manager\n⊹ Close" | run_fuzzel "Device Mounted: " "" "-l 2")
        if [[ "$open_choice" == "⊹ Open in File Manager" ]]; then
            $FILE_MANAGER "$mount_point" &
        fi
    else
        notify "Storage Manager" "Failed to mount /dev/$device_name" "critical"
        # Clean up mount point if empty
        rmdir "$mount_point" 2>/dev/null || true
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
        notify "Storage Manager" "No mounted removable devices found."
        return 0
    fi

    local selected
    selected=$(run_fuzzel "Unmount Device: " "$(printf "%s\n" "${mounted_devices[@]}")" "-l ${#mounted_devices[@]}") || return 1

    local device_data="${device_map["$selected"]}"
    IFS='|' read -r device_name mount_point <<<"$device_data"

    notify "Storage Manager" "Unmounting $mount_point..."

    # Sync before unmounting
    sync

    # Try regular unmount first
    if umount "$mount_point" 2>/dev/null || pkexec umount "$mount_point"; then
        notify "Storage Manager" "Successfully unmounted $mount_point"
        # Clean up mount point
        rmdir "$mount_point" 2>/dev/null || true
    else
        # Force unmount if regular fails
        local force_choice=$(echo -e "⊹ Force Unmount\n⊹ Cancel" | run_fuzzel "Device Busy: " "" "-l 2")
        if [[ "$force_choice" == "⊹ Force Unmount" ]]; then
            if pkexec umount -f "$mount_point"; then
                notify "Storage Manager" "Force unmounted $mount_point"
                rmdir "$mount_point" 2>/dev/null || true
            else
                notify "Storage Manager" "Failed to unmount $mount_point" "critical"
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
        notify "Storage Manager" "No mounted devices found."
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

    # Get filesystem info
    if command -v blkid &>/dev/null; then
        local fs_info=$(sudo blkid "$device" 2>/dev/null || pkexec blkid "$device" 2>/dev/null)
        info+="\n\nFilesystem Info:\n$fs_info"
    fi

    notify "Device Properties" "$info"
}

# Format device (DANGEROUS)
format_device() {
    notify "Storage Manager" "Format functionality disabled for safety. Use GParted or similar tools." "critical"
    return 0

    # If you really want this functionality, uncomment below
    # But BE VERY CAREFUL - this can destroy data!

    # local confirm=$(echo -e "⊹ Cancel\n⊹ I understand this will ERASE ALL DATA" | \
    #                run_fuzzel "⚠️ WARNING: Format will DESTROY ALL DATA! " "" "-l 2")
    #
    # if [[ "$confirm" != "⊹ I understand this will ERASE ALL DATA" ]]; then
    #     return 0
    # fi
    #
    # # ... format logic here ...
}

# Smart eject (unmount all partitions of a device)
smart_eject() {
    local devices_json=$(get_block_devices)

    # Get unique physical devices that have mounted partitions
    local physical_devices=()
    declare -A device_info_map

    while IFS= read -r device_data; do
        physical_devices+=("$device_data")
    done < <(echo "$devices_json" | jq -r '
        .blockdevices[]? |
        select(.type == "disk") |
        select(.children[]?.mountpoint? and .children[]?.mountpoint != "Not Mounted") |
        "\(.name)|\(.model // .vendor // "Unknown")|\(.size)|\(.rm // false)"
    ' | sort -u)

    if [[ ${#physical_devices[@]} -eq 0 ]]; then
        notify "Storage Manager" "No removable devices with mounted partitions found."
        return 0
    fi

    local formatted_devices=()
    declare -A eject_map

    for device_data in "${physical_devices[@]}"; do
        IFS='|' read -r name model size removable <<<"$device_data"
        local entry="⊹ $model (/dev/$name) - $size"
        formatted_devices+=("$entry")
        eject_map["$entry"]="$name"
    done

    local selected
    selected=$(run_fuzzel "Eject Device: " "$(printf "%s\n" "${formatted_devices[@]}")" "-l ${#formatted_devices[@]}") || return 1

    local device_name="${eject_map["$selected"]}"

    notify "Storage Manager" "Ejecting /dev/$device_name and all its partitions..."

    # Unmount all partitions of the device
    local failed=0
    while IFS= read -r partition; do
        local mountpoint=$(lsblk -no MOUNTPOINT "/dev/$partition" 2>/dev/null)
        if [[ -n "$mountpoint" ]] && [[ "$mountpoint" != "" ]]; then
            sync
            if ! umount "$mountpoint" 2>/dev/null && ! pkexec umount "$mountpoint" 2>/dev/null; then
                failed=1
                notify "Storage Manager" "Failed to unmount $mountpoint" "critical"
            fi
        fi
    done < <(lsblk -ln -o NAME "/dev/$device_name" | grep -v "^$device_name$")

    if [[ $failed -eq 0 ]]; then
        # Power off the device if possible
        if command -v udisksctl &>/dev/null; then
            udisksctl power-off -b "/dev/$device_name" 2>/dev/null || true
        fi
        notify "Storage Manager" "Successfully ejected /dev/$device_name. Safe to remove."
    else
        notify "Storage Manager" "Some partitions could not be unmounted. Device may be in use." "critical"
    fi
}

# --- Main Menu ---

main() {
    check_permissions

    local main_menu_options=$(
        cat <<EOF
⊹ List All Devices
⊹ Mount Device
⊹ Unmount Device
⊹ Explore Device
⊹ Smart Eject (Safe Removal)
⊹ Refresh Device List
⊹ Open Disks Utility
⊹ Open Dust
EOF
    )

    local num_main_options=7
    local main_menu_specific_args="-l $num_main_options"

    local choice
    choice=$(run_fuzzel "$PROMPT" "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "⊹ List All Devices")
        list_devices
        ;;
    "⊹ Mount Device")
        mount_device
        ;;
    "⊹ Unmount Device")
        unmount_device
        ;;
    "⊹ Explore Device")
        explore_device
        ;;
    "⊹ Smart Eject (Safe Removal)")
        smart_eject
        ;;
    "⊹ Refresh Device List")
        # Force refresh of device list
        partprobe 2>/dev/null || pkexec partprobe 2>/dev/null || true
        notify "Storage Manager" "Device list refreshed"
        exec "$0"
        ;;
    "⊹ Open Disks Utility")
        if command -v gnome-disks &>/dev/null; then
            gnome-disks &
        else
            notify "Storage Manager" "GNOME Disks not installed. Add package to home manager and rebuild: nixos.gnome.gnome-disk-utility"
        fi
        ;;
    "⊹ Open Dust")
        if command -v dust &>/dev/null; then
            $TERMINAL -e --hold dust &
        else
            notify "Storage Manager" "Dust not installed. Add package to home manager and rebuild: dust"
        fi
        ;;
    *)
        notify "Storage Manager" "Invalid option selected: $choice"
        ;;
    esac
}

main
