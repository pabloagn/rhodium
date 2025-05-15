#!/usr/bin/env bash

# scripts/desktop/wm/hyprland/autostart.sh

# Wallpaper
hyprpaper &

# Autostart network manager
nm-applet --indicator &

# Execute bluetooth utils
blueman-applet &

# Wallpaper & menu bar
waybar &
