#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-power"
APP_TITLE="Rhodium's Power Menu"
PROMPT="ψ: "

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/shared-functions.sh" ]]; then
    source "$SCRIPT_DIR/shared-functions.sh"
else
    echo "Error: shared-functions.sh not found" >&2
    exit 1
fi

# --- Main Menu Options ---
declare -A menu_options=(
    ["$(provide_fuzzel_entry) Power Off"]="power_off"
    ["$(provide_fuzzel_entry) Reboot"]="reboot_system"
    ["$(provide_fuzzel_entry) Log Out"]="log_out"
    ["$(provide_fuzzel_entry) Suspend"]="suspend_system"
    ["$(provide_fuzzel_entry) Hibernate"]="hibernate_system"
    ["$(provide_fuzzel_entry) Lock Screen"]="lock_screen"
    ["$(provide_fuzzel_entry) Toggle Airplane Mode"]="toggle_airplane_mode"
    ["$(provide_fuzzel_entry) Reload Waybar"]="reload_waybar"
)

# --- Power Menu Actions ---

# Power off the system
power_off() {
    notify "$APP_TITLE" "Shutting down system..."
    systemctl poweroff
}

# Reboot the system
reboot_system() {
    notify "$APP_TITLE" "Rebooting system..."
    systemctl reboot
}

# Log out from current session
log_out() {
    notify "$APP_TITLE" "Logging out..."
    niri msg action quit
}

# Suspend the system
suspend_system() {
    notify "$APP_TITLE" "Suspending system..."
    systemctl suspend
}

# Hibernate the system
hibernate_system() {
    notify "$APP_TITLE" "Hibernating system..."
    systemctl hibernate
}

# Lock the screen
lock_screen() {
    notify "$APP_TITLE" "Locking screen..."
    hyprlock
}

# Toggle airplane mode (disable/enable WiFi and Bluetooth)
toggle_airplane_mode() {
    # Check current state of airplane mode using rfkill
    if rfkill list all | grep -q "Soft blocked: yes"; then
        # Airplane mode is on, turn it off
        notify "$APP_TITLE" "Disabling airplane mode..."
        rfkill unblock all
        notify "$APP_TITLE" "Airplane mode disabled - WiFi and Bluetooth enabled"
    else
        # Airplane mode is off, turn it on
        notify "$APP_TITLE" "Enabling airplane mode..."
        rfkill block all
        notify "$APP_TITLE" "Airplane mode enabled - WiFi and Bluetooth disabled"
    fi
}

# Reload Waybar
reload_waybar() {
    notify "$APP_TITLE" "Reloading Waybar..."
    killall -SIGUSR2 waybar || {
        # If SIGUSR2 doesn't work, restart waybar
        killall waybar
        waybar &
    }
    notify "$APP_TITLE" "Waybar reloaded"
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
            break # Exit after executing power action
        fi
    done
}

main
