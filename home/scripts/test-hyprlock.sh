#!/usr/bin/env bash

# Hyprlock Testing Script - using SIGUSR1 for instant unlock

echo "=== Hyprlock Live Testing ==="
echo ""
echo "This script lets you test hyprlock without entering password"
echo ""

# Function to test hyprlock
test_hyprlock() {
    echo "Starting hyprlock..."
    echo "It will auto-unlock in 3 seconds"
    echo ""
    
    # Start hyprlock in background
    hyprlock &
    HYPRLOCK_PID=$!
    
    # Wait 3 seconds to see the lockscreen
    sleep 3
    
    # Send SIGUSR1 to unlock without password
    kill -USR1 $HYPRLOCK_PID
    
    echo "Unlocked! Edit your config and run again."
}

# Function for continuous testing with file watching
watch_mode() {
    CONFIG="$HOME/.config/hypr/hyprlock.conf"
    echo "Watching $CONFIG for changes..."
    echo "Save your config to see changes immediately"
    echo "Press Ctrl+C to stop"
    echo ""
    
    # Initial test
    test_hyprlock
    
    # Get initial modification time
    LAST_MOD=$(stat -c %Y "$CONFIG" 2>/dev/null || stat -f %m "$CONFIG")
    
    while true; do
        sleep 1
        CURRENT_MOD=$(stat -c %Y "$CONFIG" 2>/dev/null || stat -f %m "$CONFIG")
        
        if [ "$LAST_MOD" != "$CURRENT_MOD" ]; then
            LAST_MOD=$CURRENT_MOD
            echo ""
            echo "Config changed, reloading..."
            test_hyprlock
        fi
    done
}

# Menu
echo "Choose mode:"
echo "1) Single test (3 second preview)"
echo "2) Watch mode (auto-reload on config changes)"
echo ""
read -p "Choice (1-2): " choice

case $choice in
    1) test_hyprlock ;;
    2) watch_mode ;;
    *) echo "Invalid choice" ;;
esac
