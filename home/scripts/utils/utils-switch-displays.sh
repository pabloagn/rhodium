#!/usr/bin/env bash

set -euo pipefail

CARD="card1"
LAPTOP="eDP-1"
WL_DISPLAY="wayland-1"
export WAYLAND_DISPLAY="$WL_DISPLAY"

WR=$(command -v wlr-randr) || {
    echo "wlr-randr not in PATH" >&2
    exit 1
}

read_attr() { cat "/sys/class/drm/$1/$2" 2>/dev/null || echo unknown; }
enable_output() { "$WR" --output "$1" --on --preferred; }
disable_output() { "$WR" --output "$1" --off; }

laptop_enabled=$(read_attr "${CARD}-${LAPTOP}" enabled)

connected_hdmis=()
all_hdmis=()
for p in /sys/class/drm/${CARD}-HDMI-A-*; do # ← unquoted glob
    [[ -e $p ]] || continue
    name=${p##*/}          # card1-HDMI-A-1
    short=${name#${CARD}-} # HDMI-A-1
    all_hdmis+=("$short")
    [[ $(read_attr "$name" status) == "connected" ]] && connected_hdmis+=("$short")
done

if ((${#connected_hdmis[@]})); then
    [[ "$laptop_enabled" == "enabled" ]] && disable_output "$LAPTOP"
    for h in "${connected_hdmis[@]}"; do
        [[ $(read_attr "${CARD}-${h}" enabled) == "disabled" ]] && enable_output "$h"
    done
    for h in "${all_hdmis[@]}"; do
        [[ ! " ${connected_hdmis[*]} " =~ " $h " ]] &&
            [[ $(read_attr "${CARD}-${h}" enabled) == "enabled" ]] &&
            disable_output "$h"
    done
else
    [[ "$laptop_enabled" != "enabled" ]] && enable_output "$LAPTOP"
    for h in "${all_hdmis[@]}"; do
        [[ $(read_attr "${CARD}-${h}" enabled) == "enabled" ]] && disable_output "$h"
    done
fi
