#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-services"
APP_TITLE="Rhodium's Service Manager"
PROMPT="Σ: "

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Configuration ---
PADDING_ARGS="60 15 50" # service name, status, description

# --- Helper Functions ---

get_service_status() {
    local service="$1"
    systemctl --user is-active "$service" 2>/dev/null || echo "inactive"
}

get_service_enabled() {
    local service="$1"
    systemctl --user is-enabled "$service" 2>/dev/null || echo "disabled"
}

get_service_description() {
    local service="$1"
    systemctl --user show "$service" --property=Description --value 2>/dev/null || echo "No description"
}

format_status_indicator() {
    local status="$1"
    case "$status" in
    "active") echo "▲ Running" ;;
    "inactive") echo "▼ Stopped" ;;
    "failed") echo "✗ Failed" ;;
    "activating") echo "△ Starting" ;;
    "deactivating") echo "▽ Stopping" ;;
    *) echo "○ Unknown" ;;
    esac
}

list_user_services() {
    # Get all user services (excluding templates and masked)
    systemctl --user list-unit-files --type=service --no-legend |
        grep -v '@\|masked' |
        awk '{print $1}' |
        sort
}

show_service_list() {
    local -a paddings
    read -ra paddings <<<"$PADDING_ARGS"

    local all_entries=""

    # Batch get list of services (excluding templates and masked)
    local services=()
    while read -r unit; do
        services+=("$unit")
    done < <(systemctl --user list-unit-files --type=service --no-legend | grep -v '@\|masked' | awk '{print $1}' | sort)

    # Batch get metadata
    local metadata
    metadata=$(systemctl --user show "${services[@]}" --property=Id,Description,ActiveState --no-pager 2>/dev/null)

    # Parse metadata
    declare -A descriptions
    declare -A states

    local current_service=""
    while IFS= read -r line; do
        case "$line" in
        Id=*)
            current_service="${line#Id=}"
            ;;
        Description=*)
            descriptions["$current_service"]="${line#Description=}"
            ;;
        ActiveState=*)
            states["$current_service"]="${line#ActiveState=}"
            ;;
        esac
    done <<<"$metadata"

    for service in "${services[@]}"; do
        local description="${descriptions[$service]:-No description}"
        local status="${states[$service]:-inactive}"
        local status_display
        status_display=$(format_status_indicator "$status")

        local formatted_text=""
        local parts=("$(provide_fuzzel_entry) $service" "$status_display" "$description")
        local num_parts=${#parts[@]}
        local num_paddings=${#paddings[@]}

        for ((i = 0; i < num_parts; i++)); do
            local part="${parts[i]}"
            if ((i < num_paddings)); then
                local pad_to=${paddings[i]}
                formatted_text+=$(printf "%-*s" "$pad_to" "$part")
            else
                formatted_text+="$part"
            fi
            if ((i < num_parts - 1)); then
                formatted_text+=" "
            fi
        done

        all_entries+="$formatted_text\n"
    done

    if [[ -z "$all_entries" ]]; then
        notify "$APP_TITLE" "No user services found"
        return 1
    fi

    echo -e "$all_entries"
}

show_service_actions() {
    local selected_line="$1"
    # Extract service name from the formatted line
    local service_name
    service_name=$(echo "$selected_line" | awk '{print $2}') # Second field after the icon

    local current_status
    current_status=$(get_service_status "$service_name")

    # Build action menu based on current status
    local actions=""

    case "$current_status" in
    "active")
        actions+="$(provide_fuzzel_entry) Stop $service_name\n"
        actions+="$(provide_fuzzel_entry) Restart $service_name\n"
        ;;
    "inactive" | "failed")
        actions+="$(provide_fuzzel_entry) Start $service_name\n"
        actions+="$(provide_fuzzel_entry) Restart $service_name\n"
        ;;
    *)
        actions+="$(provide_fuzzel_entry) Start $service_name\n"
        actions+="$(provide_fuzzel_entry) Stop $service_name\n"
        actions+="$(provide_fuzzel_entry) Restart $service_name\n"
        ;;
    esac

    actions+="$(provide_fuzzel_entry) View Status $service_name\n"
    actions+="$(provide_fuzzel_entry) View Logs $service_name\n"
    actions+="$(provide_fuzzel_entry) Back to Service List"

    local action_choice
    action_choice=$(echo -e "$actions" | fuzzel --dmenu --prompt="Service: $service_name $(format_status_indicator "$current_status") " -l 7)

    [[ -z "$action_choice" ]] && return 1

    case "$action_choice" in
    "$(provide_fuzzel_entry) Start $service_name")
        start_service "$service_name"
        ;;
    "$(provide_fuzzel_entry) Stop $service_name")
        stop_service "$service_name"
        ;;
    "$(provide_fuzzel_entry) Restart $service_name")
        restart_service "$service_name"
        ;;
    "$(provide_fuzzel_entry) View Status $service_name")
        view_service_status "$service_name"
        ;;
    "$(provide_fuzzel_entry) View Logs $service_name")
        view_service_logs "$service_name"
        ;;
    "$(provide_fuzzel_entry) Back to Service List")
        return 1 # Signal to return to main menu
        ;;
    esac
}

# --- Service Actions ---

start_service() {
    local service="$1"
    notify "$APP_TITLE" "Starting $service..."

    if systemctl --user start "$service"; then
        notify "$APP_TITLE" "▲ Started $service successfully"
    else
        notify "$APP_TITLE" "✗ Failed to start $service"
    fi
}

stop_service() {
    local service="$1"
    notify "$APP_TITLE" "Stopping $service..."

    if systemctl --user stop "$service"; then
        notify "$APP_TITLE" "▼ Stopped $service successfully"
    else
        notify "$APP_TITLE" "✗ Failed to stop $service"
    fi
}

restart_service() {
    local service="$1"
    notify "$APP_TITLE" "Restarting $service..."

    if systemctl --user restart "$service"; then
        notify "$APP_TITLE" "⟲ Restarted $service successfully"
    else
        notify "$APP_TITLE" "✗ Failed to restart $service"
    fi
}

view_service_status() {
    local service="$1"
    local status_info
    status_info=$(systemctl --user status "$service" --no-pager -l 2>&1 || true)

    # Show in a temporary file and open with default text viewer
    local temp_file
    temp_file=$(mktemp)
    echo "=== $service Status ===" >"$temp_file"
    echo "$status_info" >>"$temp_file"

    if command -v "$EDITOR" &>/dev/null; then
        $EDITOR "$temp_file"
    elif command -v less &>/dev/null; then
        less "$temp_file"
    else
        cat "$temp_file"
    fi

    rm -f "$temp_file"
}

view_service_logs() {
    local service="$1"
    notify "$APP_TITLE" "Opening logs for $service..."

    if command -v journalctl &>/dev/null; then
        # Open logs in a terminal or pager
        journalctl --user -u "$service" --no-pager -n 100
    else
        notify "$APP_TITLE" "journalctl not available"
    fi
}

# --- Main Logic ---
main() {
    while true; do
        local service_list
        service_list=$(show_service_list) || break

        local selected_service
        selected_service=$(echo -e "$service_list" | fuzzel --dmenu --prompt="$PROMPT" -w 120)

        [[ -z "$selected_service" ]] && break

        # Show actions for selected service, loop back if user wants to return
        show_service_actions "$selected_service" && break
    done
}

main
