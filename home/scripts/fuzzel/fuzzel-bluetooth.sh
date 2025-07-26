#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "bluetooth"

declare -A menu_options=(
  ["$(provide_fuzzel_entry) Enable Bluetooth"]="enable_bluetooth"
  ["$(provide_fuzzel_entry) Disable Bluetooth"]="disable_bluetooth"
  ["$(provide_fuzzel_entry) Scan for Devices"]="scan_for_devices"
  ["$(provide_fuzzel_entry) Connect Device"]="connect_device"
  ["$(provide_fuzzel_entry) Disconnect Device"]="disconnect_device"
  ["$(provide_fuzzel_entry) Blueman Adapters"]="blueman_adapters"
  ["$(provide_fuzzel_entry) Blueman Services"]="blueman_services"
  ["$(provide_fuzzel_entry) List Interfaces"]="list_interfaces"
  ["$(provide_fuzzel_entry) List Connected Devices"]="list_connected_devices"
  ["$(provide_fuzzel_entry) Remove Device"]="remove_device"
)

# --- Configuration ---

# Maximum number of lines for dynamic lists (e.g., devices).
# If more entries are found, fuzzel will enable scrolling/paging.
MAX_DYNAMIC_LINES=15

# Function to run fuzzel with given prompt, input data, and optional extra arguments
# Usage: run_fuzzel "Prompt:" "Input string" "Extra fuzzel args (e.g., -l 5)"
run_fuzzel() {
  local prompt="$1"
  local input_data="$2"
  local extra_args="${3:-}"

  if [[ -z "$input_data" ]]; then
    # Use existing stdin pipe if input_data is empty
    fuzzel "$(provide_fuzzel_mode)" "$extra_args" --prompt "$prompt"
  else
    # Echo input_data to fuzzel
    echo "$input_data" | fuzzel "$(provide_fuzzel_mode)" "$extra_args" --prompt "$prompt"
  fi
}

# Function to run fuzzel for password input (masked) with optional extra arguments
# Usage: run_fuzzel_password "Prompt:" "Extra fuzzel args (e.g., -l 1)"
run_fuzzel_password() {
  local prompt="$1"
  local extra_args="${2:-}" # Optional additional arguments for fuzzel
  fuzzel "$(provide_fuzzel_mode)" "$extra_args" --password --prompt "$prompt"
}

# --- Launchers ---
blueman_adapters() {
  blueman-adapters
}

blueman_services() {
  blueman-services
}

# --- Bluetooth Specific Helper Functions ---

# Extracts device alias from bluetoothctl info output (preferred name for display)
get_device_alias() {
  local mac="$1"
  # Use 'info' command to get alias, handle potential non-existent devices
  bluetoothctl info "$mac" 2>/dev/null | grep -E '^\s*Alias:' | cut -d ':' -f 2- | xargs
}

# Get battery percentage for a Bluetooth device using upower
get_battery_percentage() {
  local mac="$1"
  # Convert MAC to UPower path format (e.g., AA_BB_CC_DD_EE_FF)
  local upower_mac_format=$(echo "$mac" | tr ':' '_')
  local upower_device_path="/org/freedesktop/UPower/devices/bluetooth_device_${upower_mac_format}"

  if command -v upower &>/dev/null; then
    local percentage=$(upower -i "$upower_device_path" 2>/dev/null | grep -E '^\s*percentage:' | awk '{print $2}')
    if [[ -n "$percentage" ]]; then
      echo "Battery: $percentage"
      return 0
    fi
  fi
  return 1 # Indicate no battery info found or upower not available
}

# --- Bluetooth Menu Actions ---

# Enables Bluetooth power (overrides any GUI blocks)
enable_bluetooth() {
  notify "$APP_TITLE" "Enabling Bluetooth..."

  # First try to unblock rfkill if it's blocked
  if command -v rfkill &>/dev/null; then
    rfkill unblock bluetooth 2>/dev/null || true
  fi

  # Then try to power on via bluetoothctl
  if bluetoothctl power on &>/dev/null; then
    notify "$APP_TITLE" "Bluetooth enabled."
  else
    # Try reset approach if direct power on fails
    echo -e "power off\npower on\nquit" | bluetoothctl &>/dev/null
    sleep 1
    if bluetoothctl power on &>/dev/null; then
      notify "$APP_TITLE" "Bluetooth enabled."
    else
      notify "$APP_TITLE" "Failed to enable Bluetooth. Check bluetooth service status and permissions."
    fi
  fi
}

# Disables Bluetooth power (hard disable with rfkill block)
disable_bluetooth() {
  notify "$APP_TITLE" "Disabling Bluetooth..."

  # First disconnect all devices
  local connected_devices=$(bluetoothctl devices Connected 2>/dev/null | awk '{print $2}')
  if [[ -n "$connected_devices" ]]; then
    while IFS= read -r mac; do
      bluetoothctl disconnect "$mac" &>/dev/null || true
    done <<<"$connected_devices"
  fi

  # Power off via bluetoothctl
  bluetoothctl power off &>/dev/null || true

  # Block via rfkill to prevent re-enabling
  if command -v rfkill &>/dev/null; then
    rfkill block bluetooth 2>/dev/null || true
  fi

  notify "$APP_TITLE" "Bluetooth disabled."
}

# Starts scanning for discoverable devices
scan_for_devices() {
  notify "$APP_TITLE" "Starting device discovery (this runs in the background)..."

  if echo -e "scan on\nquit" | bluetoothctl &>/dev/null; then
    notify "$APP_TITLE" "Device discovery initiated. Use 'Connect device' to see found devices."
  else
    notify "$APP_TITLE" "Failed to initiate discovery. Bluetooth daemon might not be running or permissions are insufficient."
  fi
}

# Lists Bluetooth interfaces (controllers)
list_interfaces() {
  local controllers_raw=$(bluetoothctl list 2>/dev/null)
  if [[ -z "$controllers_raw" ]]; then
    notify "$APP_TITLE" "No Bluetooth interfaces found. Is Bluetooth enabled?"
    return 0
  fi

  local formatted_list_array=()
  while IFS= read -r line; do
    if [[ "$line" =~ Controller\ ([0-9A-Fa-f:]{17})\ (.+)\ \[default\] ]]; then
      local mac="${BASH_REMATCH[1]}"
      local alias_name="${BASH_REMATCH[2]}"
      formatted_list_array+=("Alias: $alias_name (MAC: $mac)")
    fi
  done <<<"$controllers_raw"

  local num_options=${#formatted_list_array[@]}
  local menu_lines_arg="-l $num_options" # Exact height

  if [[ $num_options -eq 0 ]]; then
    notify "$APP_TITLE" "No active Bluetooth controllers found to display."
    return 0
  fi

  # Display the menu, but don't exit if the user cancels (just closes the info display)
  run_fuzzel "Bluetooth Interfaces: " "$(printf "%s\n" "${formatted_list_array[@]}")" "$menu_lines_arg" || true
}

# Lists all known and connected devices with their status and battery
list_connected_devices() {
  local connected_devices_macs_raw=$(bluetoothctl devices Connected 2>/dev/null | awk '{print $2}')
  if [[ -z "$connected_devices_macs_raw" ]]; then
    notify "$APP_TITLE" "No devices currently connected."
    return 0
  fi

  declare -A device_map # To store MAC for each displayed entry
  local formatted_list_array=()

  while IFS= read -r mac; do
    local alias_name=$(get_device_alias "$mac")
    local battery_status_str=""
    if get_battery_percentage "$mac" >/dev/null; then # Check if battery info exists
      battery_status_str=" ($(get_battery_percentage "$mac"))"
    fi

    local display_line="$alias_name ($mac) ${battery_status_str}"
    formatted_list_array+=("$display_line")
    device_map["$display_line"]="$mac" # Map display line back to MAC
  done <<<"$connected_devices_macs_raw"

  local num_options=${#formatted_list_array[@]}
  local display_lines=$((num_options < MAX_DYNAMIC_LINES ? num_options : MAX_DYNAMIC_LINES))
  local menu_lines_arg="-l $display_lines"

  if [[ $num_options -eq 0 ]]; then
    notify "$APP_TITLE" "No devices currently connected to display."
    return 0
  fi

  # Display the menu, but don't exit if the user cancels (just closes the info display)
  run_fuzzel "Connected Devices: " "$(printf "%s\n" "${formatted_list_array[@]}")" "$menu_lines_arg" || true
}

# Connects to a selected Bluetooth device
connect_device() {
  notify "$APP_TITLE" "Fetching available devices..."
  # 'devices' lists paired AND discovered devices. We want everything that's available.
  local available_devices_raw=$(bluetoothctl devices 2>/dev/null)

  if [[ -z "$available_devices_raw" ]]; then
    notify "$APP_TITLE" "No available devices found. Try 'Scan for devices' first, then retry."
    return 0
  fi

  declare -A device_map # Map display entry to MAC
  local formatted_list_array=()

  # Parse devices and add them to the list
  while IFS= read -r line; do
    if [[ "$line" =~ Device\ ([0-9A-Fa-f:]{17})\ (.+) ]]; then
      local mac="${BASH_REMATCH[1]}"
      local name="${BASH_REMATCH[2]}"

      local alias_name=$(get_device_alias "$mac") # Prefer alias if available
      local display_name="${alias_name:-$name}"   # Use actual name if alias is empty

      local current_info=$(bluetoothctl info "$mac" 2>/dev/null)
      local is_connected=$(echo "$current_info" | grep -c 'Connected: yes')
      local is_paired=$(echo "$current_info" | grep -c 'Paired: yes')

      local status_text=""
      if [[ "$is_connected" -gt 0 ]]; then
        status_text="[CONNECTED]"
      elif [[ "$is_paired" -gt 0 ]]; then
        status_text="[PAIRED]"
      fi

      # Only add devices that are not already connected to the list
      if [[ "$is_connected" -eq 0 ]]; then
        local entry="$display_name ($mac) $status_text"
        formatted_list_array+=("$entry")
        device_map["$entry"]="$mac"
      fi
    fi
  done <<<"$available_devices_raw"

  if [[ ${#formatted_list_array[@]} -eq 0 ]]; then
    notify "$APP_TITLE" "No new devices to connect to. All found devices are already connected or none discovered."
    return 0
  fi

  local num_options=${#formatted_list_array[@]}
  local display_lines=$((num_options < MAX_DYNAMIC_LINES ? num_options : MAX_DYNAMIC_LINES))
  local menu_lines_arg="-l $display_lines"

  local selected_line
  selected_line=$(run_fuzzel "Connect to device: " "$(printf "%s\n" "${formatted_list_array[@]}" | sort)" "$menu_lines_arg") || exit 1

  local selected_mac="${device_map["$selected_line"]}"

  if [[ -z "$selected_mac" ]]; then
    notify "$APP_TITLE" "Invalid selection or device MAC not found."
    return 1
  fi

  # Re-check status just before connecting in case it changed
  local current_status_info=$(bluetoothctl info "$selected_mac" 2>/dev/null)
  local is_paired=$(echo "$current_status_info" | grep -c 'Paired: yes')
  local is_connected=$(echo "$current_status_info" | grep -c 'Connected: yes')

  if [[ "$is_connected" -gt 0 ]]; then
    notify "$APP_TITLE" "$(get_device_alias "$selected_mac") is already connected."
    return 0
  fi

  # Attempt to pair if not already paired
  if [[ "$is_paired" -eq 0 ]]; then
    notify "$APP_TITLE" "Attempting to pair with $(get_device_alias "$selected_mac")... (Watch for PIN/Passkey prompts if required)"
    if ! bluetoothctl pair "$selected_mac" &>/dev/null; then
      notify "$APP_TITLE" "Failed to pair with $(get_device_alias "$selected_mac"). Device might be out of range, require a PIN/Passkey, or permissions issue."
      return 1
    fi
    notify "$APP_TITLE" "Paired with $(get_device_alias "$selected_mac"). Attempting to connect..."
  fi

  # Attempt to connect
  if bluetoothctl connect "$selected_mac" &>/dev/null; then
    notify "$APP_TITLE" "Successfully connected to $(get_device_alias "$selected_mac")."
  else
    notify "$APP_TITLE" "Failed to connect to $(get_device_alias "$selected_mac"). Device might be off, out of range, or failed to establish connection."
  fi
}

# Disconnects a selected Bluetooth device
disconnect_device() {
  local connected_devices_macs_raw=$(bluetoothctl devices Connected 2>/dev/null | awk '{print $2}')
  if [[ -z "$connected_devices_macs_raw" ]]; then
    notify "$APP_TITLE" "No devices currently connected to disconnect."
    return 0
  fi

  declare -A device_map # Map display entry to MAC
  local formatted_list_array=()

  while IFS= read -r mac; do
    local alias_name=$(get_device_alias "$mac")
    local entry="$alias_name ($mac)"
    formatted_list_array+=("$entry")
    device_map["$entry"]="$mac"
  done <<<"$connected_devices_macs_raw"

  local num_options=${#formatted_list_array[@]}
  local display_lines=$((num_options < MAX_DYNAMIC_LINES ? num_options : MAX_DYNAMIC_LINES))
  local menu_lines_arg="-l $display_lines"

  local selected_line
  selected_line=$(run_fuzzel "Disconnect device: " "$(printf "%s\n" "${formatted_list_array[@]}" | sort)" "$menu_lines_arg") || exit 1

  local selected_mac="${device_map["$selected_line"]}"

  if [[ -z "$selected_mac" ]]; then
    notify "$APP_TITLE" "Invalid selection or device MAC not found."
    return 1
  fi

  notify "$APP_TITLE" "Disconnecting from $(get_device_alias "$selected_mac")..."
  if bluetoothctl disconnect "$selected_mac" &>/dev/null; then
    notify "$APP_TITLE" "Disconnected from $(get_device_alias "$selected_mac")."
  else
    notify "$APP_TITLE" "Failed to disconnect from $(get_device_alias "$selected_mac")."
  fi
}

# Removes (unpairs) a selected Bluetooth device
remove_device() {
  local paired_devices_macs_raw=$(bluetoothctl devices Paired 2>/dev/null | awk '{print $2}')
  if [[ -z "$paired_devices_macs_raw" ]]; then
    notify "$APP_TITLE" "No paired devices to remove."
    return 0
  fi

  declare -A device_map # Map display entry to MAC
  local formatted_list_array=()

  while IFS= read -r mac; do
    local alias_name=$(get_device_alias "$mac")
    local entry="$alias_name ($mac)"
    formatted_list_array+=("$entry")
    device_map["$entry"]="$mac"
  done <<<"$paired_devices_macs_raw"

  local num_options=${#formatted_list_array[@]}
  local display_lines=$((num_options < MAX_DYNAMIC_LINES ? num_options : MAX_DYNAMIC_LINES))
  local menu_lines_arg="-l $display_lines"

  local selected_line
  selected_line=$(run_fuzzel "Remove device: " "$(printf "%s\n" "${formatted_list_array[@]}" | sort)" "$menu_lines_arg") || exit 1

  local selected_mac="${device_map["$selected_line"]}"

  if [[ -z "$selected_mac" ]]; then
    notify "$APP_TITLE" "Invalid selection or device MAC not found."
    return 1
  fi

  notify "$APP_TITLE" "Removing $(get_device_alias "$selected_mac")..."
  if bluetoothctl remove "$selected_mac" &>/dev/null; then
    notify "$APP_TITLE" "Successfully removed $(get_device_alias "$selected_mac")."
  else
    notify "$APP_TITLE" "Failed to remove $(get_device_alias "$selected_mac")."
  fi
}

# --- Main Logic ---
main() {
  while true; do
    local menu_items=""
    for key in "${!menu_options[@]}"; do
      menu_items="${menu_items}${key}\n"
    done

    local selected
    selected=$(echo -e "${menu_items}$(provide_fuzzel_entry) Exit" | fuzzel --dmenu --prompt="$PROMPT" -l 9)

    # Exit if cancelled or Exit selected
    [[ -z "$selected" ]] || [[ "$selected" == "$(provide_fuzzel_entry) Exit" ]] && break

    # Execute selected function
    if [[ -n "${menu_options[$selected]}" ]]; then
      ${menu_options[$selected]}
    fi
  done
}

main
