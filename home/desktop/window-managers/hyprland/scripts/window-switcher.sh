#!/usr/bin/env bash

# Get all windows
windows=$(hyprctl clients -j | jq -r '.[] | select(.workspace.id > 0) | "\(.workspace.id):\(.title) - \(.class)"')

# Show rofi menu with windows
selected=$(echo "$windows" | rofi -dmenu -i -p "Windows")

# If a window was selected, focus it
if [ -n "$selected" ]; then
    # Extract window address
    window_id=$(echo "$selected" | awk -F':' '{print $1}')

    # Focus the window
    hyprctl dispatch workspace "$window_id"
fi
