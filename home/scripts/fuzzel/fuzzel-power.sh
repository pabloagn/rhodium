#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "power"

# --- Menu Options---
options=(
  "Power Off:power_off"
  "Reboot:reboot_system"
  "Reboot to UEFI:reboot_uefi"
  "Log Out:log_out"
  "Lock Screen:lock_screen"
  "Suspend:suspend_system"
  "Hibernate:hibernate_system"
  "Toggle Airplane Mode:toggle_airplane_mode"
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

reboot_uefi() {
  notify "$APP_TITLE" "Rebooting system to UEFI..."
  systemctl reboot --firmware-setup
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

noop() {
  :
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
