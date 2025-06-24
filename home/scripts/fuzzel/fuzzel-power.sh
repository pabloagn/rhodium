#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-power"
APP_TITLE="Rhodium's Power Menu"
PROMPT="ψ: "

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Menu Options (Label:Command) ---
options=(
    "Power Off:power_off"
    "Reboot:reboot_system"
    "Log Out:log_out"
    "Lock Screen:lock_screen"
    "Suspend:suspend_system"
    "Hibernate:hibernate_system"
    "Toggle Airplane Mode:toggle_airplane_mode"
    "Reload Waybar:reload_waybar"
    "Exit:noop"
)

decorate_fuzzel_menu options

# --- Power Menu Actions ---

power_off() {
    notify "$APP_TITLE" "Shutting down system..."
    systemctl poweroff
}

reboot_system() {
    notify "$APP_TITLE" "Rebooting system..."
    systemctl reboot
}

log_out() {
    notify "$APP_TITLE" "Logging out..."
    niri msg action quit
}

suspend_system() {
    notify "$APP_TITLE" "Suspending system..."
    systemctl suspend
}

hibernate_system() {
    notify "$APP_TITLE" "Hibernating system..."
    systemctl hibernate
}

lock_screen() {
    notify "$APP_TITLE" "Locking screen..."
    hyprlock
}

toggle_airplane_mode() {
    if rfkill list all | grep -q "Soft blocked: yes"; then
        notify "$APP_TITLE" "Disabling airplane mode..."
        rfkill unblock all
        notify "$APP_TITLE" "Airplane mode disabled - WiFi and Bluetooth enabled"
    else
        notify "$APP_TITLE" "Enabling airplane mode..."
        rfkill block all
        notify "$APP_TITLE" "Airplane mode enabled - WiFi and Bluetooth disabled"
    fi
}

reload_waybar() {
    notify "$APP_TITLE" "Reloading Waybar..."
    killall -SIGUSR2 waybar || {
        killall waybar
        waybar &
    }
    notify "$APP_TITLE" "Waybar reloaded"
}

noop() {
    : # do nothing (used for Exit option)
}

# --- Main Logic ---
main() {
    local line_count
    line_count=$(get_fuzzel_line_count)

    local selected
    selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count")

    [[ -z "$selected" ]] && return

    if [[ -n "${menu_commands[$selected]:-}" ]]; then
        "${menu_commands[$selected]}"
    fi
}

main

