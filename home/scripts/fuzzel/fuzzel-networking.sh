#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"
load_metadata "fuzzel" "networking"

VPN_CONFIG_DIR="/etc/wireguard"
export SUDO_ASKPASS="$XDG_BIN_HOME"/fuzzel/fuzzel-askpass.sh

declare -a options
declare -A profile_files_map
declare -A profile_status_map

notify_vpn() { notify "VPN" "$1"; }

get_profile_name() {
    basename "$1" .conf
}

is_profile_active() {
    local name="$1"
    ip link show dev "$name" &>/dev/null && echo "▲ Connected" || echo "▼ Disconnected"
}

connect_profile() {
    local profile="$1"
    notify_vpn "Connecting to $profile…"
    sudo -A wg-quick up "$profile"
    if sudo -A wg-quick up "$profile"; then
        notify_vpn "▲ Connected to $profile"
    else
        notify_vpn "✗ Failed to connect to $profile"
    fi
    main
}

disconnect_profile() {
    local profile="$1"
    notify_vpn "Disconnecting $profile…"
    if sudo -A wg-quick down "$profile"; then
        notify_vpn "▼ Disconnected from $profile"
    else
        notify_vpn "✗ Failed to disconnect from $profile"
    fi
    main
}

show_vpn_profile_actions() {
    local profile="$1"
    local actions=()
    local status="${profile_status_map[$profile]}"

    if [[ "$status" == "▲ Connected" ]]; then
        actions+=("Disconnect $profile:disconnect_profile $profile")
    else
        actions+=("Connect $profile:connect_profile $profile")
    fi

    actions+=("Back:main")
    options=("${actions[@]}")
    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="Profile: $profile" -l "$count")
    [[ -n "$sel" && ! "$sel" =~ ^--- ]] && eval "${menu_commands[$sel]}"
}

show_vpn_profiles() {
    mapfile -t files < <(find "$VPN_CONFIG_DIR" -maxdepth 1 -type f -name '*.conf' | sort)
    options=()

    for file in "${files[@]}"; do
        local name
        name=$(get_profile_name "$file")
        profile_files_map["$name"]="$file"
        local status
        status=$(is_profile_active "$name")
        profile_status_map["$name"]="$status"
        options+=("$(printf '%-30s %s' "$name" "$status"):show_vpn_profile_actions $name")
    done

    options+=("Back:main")
    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="VPN Profiles" -l "$count")
    [[ -n "$sel" && ! "$sel" =~ ^--- ]] && eval "${menu_commands[$sel]}"
}

main() {
    options=("VPN ▸:show_vpn_profiles" "Utils ▸:noop" "Exit:noop")
    decorate_fuzzel_menu options
    local count
    count=$(get_fuzzel_line_count)
    local sel
    sel=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="Network" -l "$count")
    [[ -n "$sel" && ! "$sel" =~ ^--- ]] && eval "${menu_commands[$sel]}"
}

noop() { :; }

main

