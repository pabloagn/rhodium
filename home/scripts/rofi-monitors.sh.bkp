#!/usr/bin/env bash

# Monitor switching script for Hyprland
# Usage: ./monitor-switch.sh [laptop|external|both]

WALLPAPER_PATH="$HOME/.local/share/wallpapers/dante/wallpaper-01.jpg"

switch_to_laptop() {
    echo "Switching to laptop display only..."
    hyprctl keyword monitor "HDMI-A-1,disable"
    hyprctl keyword monitor "eDP-1,2880x1620@120,0x0,1.5"
    
    # Set wallpaper for laptop
    hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER_PATH"
}

switch_to_external() {
    echo "Switching to external display only..."
    hyprctl keyword monitor "eDP-1,disable"
    hyprctl keyword monitor "HDMI-A-1,3840x2160@60,0x0,1.5"
    
    # Preload and set wallpaper for external monitor
    hyprctl hyprpaper preload "$WALLPAPER_PATH"
    sleep 0.5  # Small delay to ensure preload completes
    hyprctl hyprpaper wallpaper "HDMI-A-1,$WALLPAPER_PATH"
}

switch_to_both() {
    echo "Enabling both displays..."
    hyprctl keyword monitor "eDP-1,2880x1620@120,0x0,1.5"
    hyprctl keyword monitor "HDMI-A-1,3840x2160@60,2880x0,1.5"
    
    # Set wallpapers for both monitors
    hyprctl hyprpaper preload "$WALLPAPER_PATH"
    sleep 0.5
    hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER_PATH"
    hyprctl hyprpaper wallpaper "HDMI-A-1,$WALLPAPER_PATH"
}

case "$1" in
    "laptop")
        switch_to_laptop
        ;;
    "external")
        switch_to_external
        ;;
    "both")
        switch_to_both
        ;;
    *)
        echo "Usage: $0 [laptop|external|both]"
        echo "  laptop   - Use laptop display only"
        echo "  external - Use external display only"
        echo "  both     - Use both displays"
        exit 1
        ;;
esac

echo "Monitor switch complete!"
