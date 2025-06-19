#!/usr/bin/env bash

set -euo pipefail

# --- Configuration ---
# Fuzzel base dmenu arguments. These apply to all fuzzel invocations unless overridden.
FUZZEL_DMENU_BASE_ARGS="--dmenu"

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
    local input_data="$2"
    local extra_args="${3:-}"

    if [[ -z "$input_data" ]]; then
        # Use existing stdin pipe if input_data is empty
        fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    else
        # Echo input_data to fuzzel
        echo "$input_data" | fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    fi
}

# --- Power Menu Actions ---

# Power off the system
power_off() {
    notify "Power Menu" "Shutting down system..."
    systemctl poweroff
}

# Reboot the system
reboot_system() {
    notify "Power Menu" "Rebooting system..."
    systemctl reboot
}

# Log out from current session
log_out() {
    notify "Power Menu" "Logging out..."
    niri msg action quit
}

# Suspend the system
suspend_system() {
    notify "Power Menu" "Suspending system..."
    systemctl suspend
}

# Hibernate the system
hibernate_system() {
    notify "Power Menu" "Hibernating system..."
    systemctl hibernate
}

# Lock the screen
lock_screen() {
    notify "Power Menu" "Locking screen..."
    hyprlock
}

# Toggle airplane mode (disable/enable WiFi and Bluetooth)
toggle_airplane_mode() {
    # Check current state of airplane mode using rfkill
    if rfkill list all | grep -q "Soft blocked: yes"; then
        # Airplane mode is on, turn it off
        notify "Power Menu" "Disabling airplane mode..."
        rfkill unblock all
        notify "Power Menu" "Airplane mode disabled - WiFi and Bluetooth enabled"
    else
        # Airplane mode is off, turn it on
        notify "Power Menu" "Enabling airplane mode..."
        rfkill block all
        notify "Power Menu" "Airplane mode enabled - WiFi and Bluetooth disabled"
    fi
}

# Reload Waybar
reload_waybar() {
    notify "Power Menu" "Reloading Waybar..."
    killall -SIGUSR2 waybar || {
        # If SIGUSR2 doesn't work, restart waybar
        killall waybar
        waybar &
    }
    notify "Power Menu" "Waybar reloaded"
}

# --- Main Logic ---

main() {
    local main_menu_options=$(
        cat <<EOF
⊹ Power Off
⊹ Reboot
⊹ Log Out
⊹ Suspend
⊹ Hibernate
⊹ Lock Screen
⊹ Toggle Airplane Mode
⊹ Reload Waybar
EOF
    )

    # Calculate the exact number of lines for the main menu
    local num_main_options=$(echo -e "$main_menu_options" | wc -l)
    local main_menu_specific_args="-l $num_main_options"

    local choice
    # Pass the calculated line count to run_fuzzel for the main menu
    choice=$(run_fuzzel "λ " "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "⊹ Power Off")
        power_off
        ;;
    "⊹ Reboot")
        reboot_system
        ;;
    "⊹ Log Out")
        log_out
        ;;
    "⊹ Suspend")
        suspend_system
        ;;
    "⊹ Hibernate")
        hibernate_system
        ;;
    "⊹ Lock Screen")
        lock_screen
        ;;
    "⊹ Reload Niri")
        reload_niri
        ;;
    "⊹ Toggle Airplane Mode")
        toggle_airplane_mode
        ;;
    "⊹ Reload Waybar")
        reload_waybar
        ;;
    *)
        notify "Power Menu" "Invalid option selected: $choice"
        ;;
    esac
}

main
