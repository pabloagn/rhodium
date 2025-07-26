#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "usb"

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

declare -a options
declare -A device_map

# --- Functions ---
notify_usb() {
  notify "USB Manager" "$1"
}

# Get USB device information
get_usb_devices() {
  local category_filter="${1:-}"

  # Get all USB devices with their properties
  for device in /sys/bus/usb/devices/*/; do
    [[ -d "$device" ]] || continue

    # Skip root hubs and interfaces
    local devnum
    devnum=$(cat "$device/devnum" 2>/dev/null || echo "0")
    [[ "$devnum" == "1" ]] && continue

    # Get device info - declare first, then assign
    local busnum idVendor idProduct manufacturer product serial bDeviceClass authorized removable
    busnum=$(cat "$device/busnum" 2>/dev/null || echo "")
    idVendor=$(cat "$device/idVendor" 2>/dev/null || echo "")
    idProduct=$(cat "$device/idProduct" 2>/dev/null || echo "")
    manufacturer=$(cat "$device/manufacturer" 2>/dev/null || echo "Unknown")
    product=$(cat "$device/product" 2>/dev/null || echo "Unknown Device")
    serial=$(cat "$device/serial" 2>/dev/null || echo "")
    bDeviceClass=$(cat "$device/bDeviceClass" 2>/dev/null || echo "00")
    authorized=$(cat "$device/authorized" 2>/dev/null || echo "1")
    removable=$(cat "$device/removable" 2>/dev/null || echo "unknown")

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
    local device_path
    device_path=$(basename "$device")
    echo "${device_path}|${busnum}|${devnum}|${idVendor}|${idProduct}|${manufacturer}|${product}|${device_type}|${authorized}|${serial}"
  done | sort -t'|' -k7,7 -k6,6
}

# Enable/disable USB device
toggle_device_state() {
  local device_path="$1"
  local action="$2" # "enable" or "disable"
  local auth_file="/sys/bus/usb/devices/$device_path/authorized"

  if [[ ! -f "$auth_file" ]]; then
    notify_usb "Cannot access device authorization file"
    return 1
  fi

  local new_state="0"
  [[ "$action" == "enable" ]] && new_state="1"

  # Try to change state
  if echo "$new_state" >"$auth_file" 2>/dev/null || pkexec bash -c "echo '$new_state' > '$auth_file'"; then
    local state_text="disabled"
    [[ "$action" == "enable" ]] && state_text="enabled"
    notify_usb "Device $state_text successfully"

    # Save state for persistence
    echo "$new_state" >"$DEVICE_STATE_DIR/$device_path" 2>/dev/null || true
    return 0
  else
    notify_usb "Failed to change device state"
    return 1
  fi
}

# Show detailed device information
show_device_info() {
  local device_path="$1"
  local device_dir="/sys/bus/usb/devices/$device_path"

  if [[ ! -d "$device_dir" ]]; then
    notify_usb "Device information not available"
    return 1
  fi

  local info="USB Device Information:\n\n"

  # Collect device information
  for attr in product manufacturer serial idVendor idProduct bcdDevice speed maxpower configuration; do
    if [[ -f "$device_dir/$attr" ]]; then
      local value
      value=$(cat "$device_dir/$attr" 2>/dev/null || echo "N/A")
      info+="$(echo "$attr" | sed 's/^./\U&/'): $value\n"
    fi
  done

  # Get driver info
  if [[ -d "$device_dir/driver" ]]; then
    local driver
    driver=$(basename "$(readlink "$device_dir/driver" 2>/dev/null)" 2>/dev/null || echo "Unknown")
    info+="Driver: $driver\n"
  fi

  notify_usb "$info"
}

# Show actions for a specific device
show_device_actions() {
  local device_data="$1"
  local filter="${2:-}"
  local device_path product_name authorized
  IFS='|' read -r device_path product_name authorized <<<"$device_data"

  while true; do
    options=()
    if [[ "$authorized" == "1" ]]; then
      options+=("Disable Device:toggle_device_state $device_path disable")
    else
      options+=("Enable Device:toggle_device_state $device_path enable")
    fi
    options+=("Device Information:show_device_info $device_path")

    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$product_name: " -l "$count")

    [[ -z "$sel" ]] && break
    [[ "$sel" =~ ^--- ]] && continue

    eval "${menu_commands[$sel]}"
    # Refresh authorized status after toggle
    authorized=$(cat "/sys/bus/usb/devices/$device_path/authorized" 2>/dev/null || echo "1")
  done
}

# Manage devices (enable/disable)
manage_devices() {
  local filter="${1:-}"

  while true; do
    local devices
    devices=$(get_usb_devices "$filter")

    if [[ -z "$devices" ]]; then
      notify_usb "No devices found in this category"
      break
    fi

    options=()
    device_map=()

    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
      local status="✓"
      if [[ "$authorized" == "0" ]]; then
        status="✗"
      fi

      local entry="$status $product_name ($type)"
      options+=("$entry:show_device_actions $path|$product_name|$authorized $filter")
    done <<<"$devices"

    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="Select Device: " -l "$count")

    [[ -z "$sel" ]] && break
    [[ "$sel" =~ ^--- ]] && continue

    eval "${menu_commands[$sel]}"
  done
}

# Manage device by category
manage_by_category() {
  while true; do
    options=(
      "Keyboards:manage_devices Keyboard"
      "Mice & Pointing Devices:manage_devices Mouse|Touchpad"
      "Webcams & Cameras:manage_devices video"
      "Microphones & Audio:manage_devices audio"
      "Storage Devices:manage_devices storage"
      "Network Devices:manage_devices network"
      "Printers & Scanners:manage_devices printer"
      "USB Hubs:manage_devices hub"
      "All Devices:manage_devices"
    )

    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="Device Category: " -l "$count")

    [[ -z "$sel" ]] && break
    [[ "$sel" =~ ^--- ]] && continue

    eval "${menu_commands[$sel]}"
  done
}

# List all USB devices
list_all_devices() {
  while true; do
    local devices
    devices=$(get_usb_devices)

    if [[ -z "$devices" ]]; then
      notify_usb "No USB devices found"
      break
    fi

    options=()
    while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
      local status="[Enabled]"
      [[ "$authorized" == "0" ]] && status="[Disabled]"

      local entry="$product_name - $type $status"
      options+=("$entry:noop")
    done <<<"$devices"

    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="USB Devices: " -l "$count")

    [[ -z "$sel" ]] && break
    [[ "$sel" =~ ^--- ]] && continue

    eval "${menu_commands[$sel]}"
  done
}

# Toggle all devices in a category
toggle_device_category() {
  local pattern="$1"
  local devices
  devices=$(get_usb_devices)
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

  notify_usb "Toggled $toggled devices"
}

# Enable all devices
enable_all_devices() {
  local devices
  devices=$(get_usb_devices)
  local enabled=0

  while IFS='|' read -r path busnum devnum vendor product manufacturer product_name type authorized serial; do
    if [[ "$authorized" == "0" ]]; then
      if toggle_device_state "$path" "enable" 2>/dev/null; then
        ((enabled++))
      fi
    fi
  done <<<"$devices"

  notify_usb "Enabled $enabled devices"
}

# Privacy mode - disable cameras and microphones
privacy_mode() {
  toggle_device_category "Webcam|Camera|Microphone|Mic"
}

# Export device list
export_device_list() {
  local export_file="/tmp/usb-devices-$(date +%Y%m%d-%H%M%S).txt"
  get_usb_devices >"$export_file"
  notify_usb "Device list exported to $export_file"
}

# Export device status for waybar
export_device_status() {
  local status_file="/tmp/usb-device-status.json"
  local devices
  devices=$(get_usb_devices)

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

  notify_usb "Device status refreshed"
}

# Quick toggle actions menu
quick_toggle_menu() {
  while true; do
    options=(
      "Toggle All Webcams:toggle_device_category Webcam|Camera"
      "Toggle All Microphones:toggle_device_category Microphone|Mic"
      "Toggle All Storage Devices:toggle_device_category Storage"
      "Enable All Devices:enable_all_devices"
    )

    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="Quick Actions: " -l "$count")

    [[ -z "$sel" ]] && break
    [[ "$sel" =~ ^--- ]] && continue

    eval "${menu_commands[$sel]}"
  done
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

  while true; do
    options=(
      "List All Devices:list_all_devices"
      "Manage by Category:manage_by_category"
      "Quick Toggle Actions:quick_toggle_menu"
      "Enable All Devices:enable_all_devices"
      "Privacy Mode:privacy_mode"
      "Export Device List:export_device_list"
      "Refresh Device Status:export_device_status"
      "Exit:noop"
    )

    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$count")

    [[ -z "$sel" ]] && break
    [[ "$sel" =~ ^--- ]] && continue

    if [[ "${menu_commands[$sel]}" == "noop" ]]; then
      break
    fi

    eval "${menu_commands[$sel]}"
  done
}

noop() { :; }

main "$@"
