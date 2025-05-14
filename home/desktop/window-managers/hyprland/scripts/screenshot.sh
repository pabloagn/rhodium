#!/usr/bin/env bash

# Screenshot script for Hyprland
# Usage: screenshot.sh [full|area|window]

# Create screenshots directory if it doesn't exist
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Generate filename with timestamp
FILENAME="$SCREENSHOT_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"

# Handle different screenshot types
case "$1" in
    full)
        # Capture entire screen
        grim "$FILENAME"
        ;;
    area)
        # Capture selected area
        grim -g "$(slurp)" "$FILENAME"
        ;;
    window)
        # Capture active window (requires additional script for window geometry)
        GEOMETRY=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$GEOMETRY" "$FILENAME"
        ;;
    *)
        # Default to full screenshot
        grim "$FILENAME"
        ;;
esac

# Notify user
if [ -f "$FILENAME" ]; then
    notify-send "Screenshot saved" "$FILENAME" -i "$FILENAME"

    # Copy to clipboard
    wl-copy < "$FILENAME"
else
    notify-send "Screenshot failed" "Failed to capture screenshot"
fi
