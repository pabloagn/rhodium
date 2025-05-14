#!/usr/bin/env bash

# Autostart script for Hyprland

# Start Waybar
waybar &

# Start notification daemon
dunst &

# Set wallpaper using swww
swww init &
sleep 1
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
DEFAULT_WALLPAPER="$WALLPAPER_DIR/current.jpg"

# Use default wallpaper if it exists, otherwise find one
if [ -f "$DEFAULT_WALLPAPER" ]; then
    swww img "$DEFAULT_WALLPAPER"
else
    # Find first image in wallpaper directory
    FIRST_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | head -n 1)
    if [ -n "$FIRST_WALLPAPER" ]; then
        swww img "$FIRST_WALLPAPER"
    fi
fi

# Start clipboard manager
wl-paste -t text --watch clipman store &

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
