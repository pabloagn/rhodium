#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

load_metadata "fuzzel" "services"

declare -a options
declare -A service_status_map

get_service_status() {
    local service="$1"
    systemctl --user is-active "$service" 2>/dev/null || echo "inactive"
}

get_service_description() {
    local service="$1"
    systemctl --user show "$service" --property=Description --value 2>/dev/null || echo "No description"
}

format_status_indicator() {
    local status="$1"
    case "$status" in
    active) echo "▲ Running" ;;
    inactive) echo "▼ Stopped" ;;
    failed) echo "✗ Failed" ;;
    activating) echo "△ Starting" ;;
    deactivating) echo "▽ Stopping" ;;
    *) echo "○ Unknown" ;;
    esac
}

list_user_services() {
    systemctl --user list-unit-files --type=service --no-legend |
        grep -v '@\|masked' |
        awk '{print $1}' |
        sort
}

generate_service_menu() {
    local services=()
    while read -r unit; do
        services+=("$unit")
    done < <(list_user_services)

    local metadata
    metadata=$(systemctl --user show "${services[@]}" --property=Id,Description,ActiveState --no-pager 2>/dev/null)

    declare -A descriptions
    declare -A states

    local current=""
    while IFS= read -r line; do
        case "$line" in
        Id=*) current="${line#Id=}" ;;
        Description=*) descriptions["$current"]="${line#Description=}" ;;
        ActiveState=*) states["$current"]="${line#ActiveState=}" ;;
        esac
    done <<<"$metadata"

    for service in "${services[@]}"; do
        local desc="${descriptions[$service]:-No description}"
        local status="${states[$service]:-inactive}"
        local display_status
        display_status=$(format_status_indicator "$status")
        service_status_map["$service"]="$status"

        local padded
        padded=$(printf "%-50s %-14s %s" "$service" "$display_status" "$desc")
        options+=("$padded:show_actions $service")
    done

    # options+=("---")
    options+=("Exit:noop")
}

show_actions() {
    local service="$1"
    local status="${service_status_map[$service]:-unknown}"
    local actions=()

    case "$status" in
    active)
        actions+=("Stop $service:stop_service $service")
        actions+=("Restart $service:restart_service $service")
        ;;
    inactive | failed)
        actions+=("Start $service:start_service $service")
        actions+=("Restart $service:restart_service $service")
        ;;
    *)
        actions+=("Start $service:start_service $service")
        actions+=("Stop $service:stop_service $service")
        actions+=("Restart $service:restart_service $service")
        ;;
    esac

    actions+=("View Status $service:view_status $service")
    actions+=("View Logs $service:view_logs $service")
    actions+=("Back:main")

    options=("${actions[@]}")
    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local selected
    selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="Service: $service" -l "$count")
    [[ -z "$selected" ]] && return
    [[ "$selected" =~ ^---.*---$ ]] && return
    eval "${menu_commands[$selected]}"
}

start_service() {
    local service="$1"
    notify "$APP_TITLE" "Starting $service..."
    systemctl --user start "$service" && notify "$APP_TITLE" "▲ Started $service" || notify "$APP_TITLE" "✗ Failed to start $service"
    main
}

stop_service() {
    local service="$1"
    notify "$APP_TITLE" "Stopping $service..."
    systemctl --user stop "$service" && notify "$APP_TITLE" "▼ Stopped $service" || notify "$APP_TITLE" "✗ Failed to stop $service"
    main
}

restart_service() {
    local service="$1"
    notify "$APP_TITLE" "Restarting $service..."
    systemctl --user restart "$service" && notify "$APP_TITLE" "⟲ Restarted $service" || notify "$APP_TITLE" "✗ Failed to restart $service"
    main
}

view_status() {
    local service=$1
    local tmpfile
    tmpfile=$(mktemp --suffix=".log") || return 1

    systemctl --user status "$service" --no-pager -l > "$tmpfile"

    # Open in a new, detached kitty window with Neovim
    kitty --detach --title "status:$service" \
        nvim -c 'setlocal readonly nomodifiable' "$tmpfile" &

    main
}

view_logs() {
    local service=$1
    notify "$APP_TITLE" "Opening logs for $service..."

    local tmpfile
    tmpfile=$(mktemp --suffix=".log") || return 1

    journalctl --user -u "$service" --no-pager -n 100 > "$tmpfile"

    kitty --detach --title "logs:$service" \
        nvim -c 'setlocal readonly nomodifiable' "$tmpfile" &

    main
}

noop() {
    :
}

main() {
    options=()
    generate_service_menu
    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local selected
    selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l 20 -w 120)
    [[ -z "$selected" ]] && return
    [[ "$selected" =~ ^---.*---$ ]] && main
    eval "${menu_commands[$selected]}"
}

main
