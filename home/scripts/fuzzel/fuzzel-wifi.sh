#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-wifi"
APP_TITLE="Rhodium's WiFi Utils"
PROMPT="ω: "

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Configuration ---
FUZZEL_DMENU_BASE_ARGS="--dmenu"
MAX_WIFI_LINES=15

# --- Helper Functions ---

# Function to send desktop notifications
notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &>/dev/null; then
        notify-send "$title" "$message"
    else
        # Fallback if notify-send is not available
        echo "Notification: $title - $message" >&2
    fi
}

# Function to run fuzzel with given prompt, input data, and optional extra arguments
# Usage: run_fuzzel "Prompt:" "Input string" "Extra fuzzel args (e.g., -l 5)"
run_fuzzel() {
    local prompt="$1"
    local input_data="$2"     # Can be a string to echo or piped input if empty
    local extra_args="${3:-}" # Optional additional arguments for fuzzel

    if [[ -z "$input_data" ]]; then
        # Use existing stdin pipe if input_data is empty
        fuzzel $FUZZEL_DMENU_BASE_ARGS "$extra_args" --prompt "$prompt"
    else
        # Echo input_data to fuzzel
        echo "$input_data" | fuzzel $FUZZEL_DMENU_BASE_ARGS "$extra_args" --prompt "$prompt"
    fi
}

# Function to run fuzzel for password input (masked) with optional extra arguments
# Usage: run_fuzzel_password "Prompt:" "Extra fuzzel args (e.g., -l 1)"
run_fuzzel_password() {
    local prompt="$1"
    local extra_args="${2:-}" # Optional additional arguments for fuzzel
    fuzzel $FUZZEL_DMENU_BASE_ARGS "$extra_args" --password --prompt "$prompt"
}

# --- Main Menu Actions ---

# Scans for Wi-Fi networks (this involves actual hardware scanning)
scan_networks() {
    notify "Wi-Fi" "Starting network scan (this takes a few seconds)..."
    if nmcli device wifi rescan &>/dev/null; then
        notify "Wi-Fi" "Network scan completed successfully."
    else
        notify "Wi-Fi Error" "Failed to scan for networks. Is Wi-Fi enabled and reachable?"
    fi
}

# Enables or disables Wi-Fi radio
toggle_wifi() {
    local state="$1" # 'on' or 'off'
    notify "Wi-Fi" "Turning Wi-Fi $state..."
    if nmcli radio wifi "$state"; then
        notify "Wi-Fi" "Wi-Fi is now $state."
    else
        notify "Wi-Fi Error" "Failed to turn Wi-Fi $state. Check permissions or status."
    fi
}

# Disconnects from an active Wi-Fi connection
disconnect_wifi() {
    local active_connections
    active_connections=$(nmcli -t -f UUID,NAME,TYPE,DEVICE connection show --active 2>/dev/null | grep ":wifi:")

    if [[ -z "$active_connections" ]]; then
        notify "Wi-Fi" "No active Wi-Fi connections to disconnect."
        return 0
    fi

    local formatted_list_array=()
    while IFS=: read -r uuid name type device; do
        formatted_list_array+=("Disconnect $name ($device)")
    done <<<"$active_connections"

    local num_options=${#formatted_list_array[@]}
    local menu_lines_arg="-l $num_options"

    local selected_line
    selected_line=$(run_fuzzel "Disconnect: " "$(printf "%s\n" "${formatted_list_array[@]}")" "$menu_lines_arg") || exit 1

    local conn_name
    conn_name=$(echo "$selected_line" | sed -E 's/^Disconnect (.*) \([^)]+\)$/\1/')

    notify "Wi-Fi" "Disconnecting from '$conn_name'..."
    if nmcli connection down "$conn_name"; then
        notify "Wi-Fi" "Disconnected from '$conn_name'."
    else
        notify "Wi-Fi Error" "Failed to disconnect from '$conn_name'."
    fi
}

# Deletes a saved Wi-Fi connection profile
delete_connection() {
    local connections
    connections=$(nmcli -t -f UUID,NAME,TYPE connection show 2>/dev/null)

    if [[ -z "$connections" ]]; then
        notify "Wi-Fi" "No saved connections to delete."
        return 0
    fi

    local formatted_list_array=()
    while IFS=: read -r uuid name type _; do
        formatted_list_array+=("Delete $name ($type)")
    done <<<"$connections"

    local num_options=${#formatted_list_array[@]}
    local menu_lines_arg="-l $num_options" # Exact height for delete menu

    local selected_line
    selected_line=$(run_fuzzel "Delete Connection: " "$(printf "%s\n" "${formatted_list_array[@]}")" "$menu_lines_arg") || exit 1

    local conn_name
    conn_name=$(echo "$selected_line" | sed -E 's/^Delete (.*) \([^)]+\)$/\1/')

    notify "Wi-Fi" "Deleting connection '$conn_name'..."
    if nmcli connection delete "$conn_name"; then
        notify "Wi-Fi" "Connection '$conn_name' deleted."
    else
        notify "Wi-Fi Error" "Failed to delete connection '$conn_name'."
    fi
}

# Handles the process of selecting and connecting to a Wi-Fi network
connect_to_network() {
    notify "Wi-Fi" "Retrieving network list (includes a fresh scan and may take a few seconds)..."

    local wifi_list
    wifi_list=$(nmcli -t -f SSID,SECURITY,SIGNAL device wifi list --rescan yes 2>/dev/null)

    if [[ -z "$wifi_list" ]]; then
        notify "Wi-Fi" "No Wi-Fi networks found or scan failed. Is Wi-Fi enabled?"
        return 0
    fi

    declare -A ssid_info_map
    declare -a network_display_entries # Array to store lines for fuzzel

    while IFS=: read -r ssid security signal; do
        if [[ -z "$ssid" || "$ssid" == "--" ]]; then
            continue
        fi

        local display_symbol="⌽"
        if [[ "$security" != "--" && "$security" != "none" ]]; then
            display_symbol="⌽"
        fi

        local current_info="${ssid_info_map[$ssid]:-}"

        local current_signal
        current_signal=$(echo "$current_info" | awk -F'|' '{print $2}')

        local current_symbol
        current_symbol=$(echo "$current_info" | awk -F'|' '{print $1}')

        local signal_int=-1
        if [[ "$signal" =~ ^[0-9]+$ ]]; then
            signal_int="$signal"
        fi

        local current_signal_int=-1
        if [[ "$current_signal" =~ ^[0-9]+$ ]]; then
            current_signal_int="$current_signal"
        fi

        if [[ -z "$current_info" ]]; then
            ssid_info_map["$ssid"]="${display_symbol}|${signal_int}"
        elif [[ "$display_symbol" == "⌽" && "$current_symbol" == "⌽" ]]; then
            ssid_info_map["$ssid"]="${display_symbol}|${signal_int}"
        elif [[ "$display_symbol" == "$current_symbol" && "$signal_int" -gt "$current_signal_int" ]]; then
            ssid_info_map["$ssid"]="${display_symbol}|${signal_int}"
        fi
    done <<<"$wifi_list"

    # Populate the array for fuzzel display
    for ssid in "${!ssid_info_map[@]}"; do
        local info="${ssid_info_map[$ssid]}"
        local symbol
        symbol=$(echo "$info" | awk -F'|' '{print $1}')

        local signal
        signal=$(echo "$info" | awk -F'|' '{print $2}')

        local signal_display=""
        if [[ "$signal" -ge 0 ]]; then
            signal_display=" (${signal}%)"
        fi
        network_display_entries+=("$symbol $ssid$signal_display")
    done

    if [[ ${#network_display_entries[@]} -eq 0 ]]; then
        notify "Wi-Fi" "No valid networks found to display."
        return 0
    fi

    # Calculate dynamic line count: min of actual entries or MAX_WIFI_LINES
    local num_wifi_entries=${#network_display_entries[@]}
    local display_lines=$((num_wifi_entries < MAX_WIFI_LINES ? num_wifi_entries : MAX_WIFI_LINES))
    local wifi_menu_specific_args="-l $display_lines"

    local selected_network_line
    # Pipe the sorted network entries to fuzzel
    selected_network_line=$(printf "%s\n" "${network_display_entries[@]}" | sort | run_fuzzel "Connect to: " "" "$wifi_menu_specific_args") || exit 1

    local selected_ssid
    selected_ssid=$(echo "$selected_network_line" | sed -E 's/^[⌽⌽]\s+//; s/\s+\([0-9]+%\)$//' | xargs)

    if [[ -z "$selected_ssid" ]]; then
        notify "Wi-Fi" "No network selected or invalid selection. Connection cancelled."
        return 1
    fi

    if ! [[ -v "ssid_info_map[$selected_ssid]" ]]; then
        notify "Wi-Fi Error" "Internal error: Selected network '$selected_ssid' not found in processed list. Please try 'Scan networks' and then 'Connect to network' again."
        return 1
    fi

    local security_status
    security_status=$(echo "${ssid_info_map[$selected_ssid]}" | awk -F'|' '{print $1}')

    local password=""

    if [[ "$security_status" == "⌽" ]]; then
        # Password prompt also uses a specific line count (usually 1 line)
        password=$(run_fuzzel_password "Password for $selected_ssid: " "-l 1") || exit 1
        if [[ -z "$password" ]]; then
            notify "Wi-Fi" "Connection cancelled (no password provided)."
            return 1
        fi
    fi

    notify "Wi-Fi" "Attempting to connect to '$selected_ssid'..."

    if [[ -n "$password" ]]; then
        if nmcli device wifi connect "$selected_ssid" password "$password"; then
            notify "Wi-Fi" "Successfully connected to '$selected_ssid'."
        else
            notify "Wi-Fi Error" "Failed to connect to '$selected_ssid'. Incorrect password or network issue."
        fi
    else
        if nmcli device wifi connect "$selected_ssid"; then
            notify "Wi-Fi" "Successfully connected to '$selected_ssid'."
        else
            notify "Wi-Fi Error" "Failed to connect to '$selected_ssid'. Possible network issue or it requires a password."
        fi
    fi
}

# --- Main Logic ---

main() {
    local main_menu_options
    main_menu_options=$(
        cat <<EOF
Scan networks
Enable Wifi
Disable Wifi
Connect to network
Disconnect from network
Delete saved connection
EOF
    )
    # Calculate the exact number of lines for the main menu
    local num_main_options
    num_main_options=$(echo -e "$main_menu_options" | wc -l)
    local main_menu_specific_args="-l $num_main_options"

    local choice
    # Pass the calculated line count to run_fuzzel for the main menu
    choice=$(run_fuzzel "$PROMPT" "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "Scan networks")
        scan_networks
        ;;
    "Enable Wifi")
        toggle_wifi "on"
        ;;
    "Disable Wifi")
        toggle_wifi "off"
        ;;
    "Connect to network")
        connect_to_network
        ;;
    "Disconnect from network")
        disconnect_wifi
        ;;
    "Delete saved connection")
        delete_connection
        ;;
    *)
        notify "Wi-Fi" "Invalid option selected: $choice"
        ;;
    esac
}

main
