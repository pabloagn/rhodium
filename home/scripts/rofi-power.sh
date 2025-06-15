#!/usr/bin/env bash

set -euo pipefail

power_menu() {
    ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

    local options=(
        "⊹ Power Off <i>(Shutdown System)</i>"
        "⊹ Reboot <i>(Restart System)</i>"
        "⊹ Log Out <i>(End Session)</i>"
        "⊹ Suspend <i>(Sleep Mode)</i>"
        "⊹ Hibernate <i>(Deep Sleep)</i>"
        "⊹ Lock Screen <i>(Secure Session)</i>"
        "⊹ Reload Hyprland <i>(Restart WM)</i>"
    )

    local commands=(
        "systemctl poweroff"
        "systemctl reboot"
        "hyprctl dispatch exit"
        "systemctl suspend"
        "systemctl hibernate"
        "hyprlock"
        "hyprctl reload"
    )

    selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)
    [[ -z "$selected" ]] && return

    # Direct lookup and execute
    for i in "${!options[@]}"; do
        if [[ "${options[$i]}" == "$selected" ]]; then
            eval "${commands[$i]}" &
            break
        fi
    done
}

power_menu
