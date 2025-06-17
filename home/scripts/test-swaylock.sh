#!/usr/bin/env bash

echo "Sacred Computer Swaylock Test Suite"
echo "==================================="
echo ""

# Basic test with config file
test_basic() {
    echo "1. Testing basic lock with config file..."
    echo "   Press Ctrl+C to cancel if stuck"
    swaylock
}

# Test with explicit command (no config)
test_explicit() {
    echo "2. Testing with explicit flags (ignoring config)..."
    swaylock \
        --image /home/pabloagn/.local/share/wallpapers/dante/wallpaper-01.jpg \
        --scaling fill \
        --color 1a1a1aff \
        --font "JetBrains Mono Nerd Font" \
        --font-size 14 \
        --indicator-radius 80 \
        --indicator-thickness 4 \
        --ring-color 2a2a2a00 \
        --ring-ver-color 3c3c3cff \
        --ring-wrong-color 555555ff \
        --inside-color 1a1a1a00 \
        --inside-ver-color 2a2a2aaa \
        --inside-wrong-color 3a3a3aaa \
        --text-color ffffffaa \
        --text-ver-color ffffff00 \
        --text-wrong-color ffffffff \
        --key-hl-color 5588aaff \
        --line-color 00000000 \
        --separator-color 00000000 \
        --show-failed-attempts \
        --indicator-idle-visible
}

# Test different states
test_states() {
    echo "3. Testing different visual states..."
    echo ""
    echo "   When locked:"
    echo "   - Type to see key highlights (blue segments)"
    echo "   - Press Backspace to see backspace highlight"
    echo "   - Press Caps Lock to see caps lock state"
    echo "   - Enter wrong password to see error state"
    echo "   - Press Escape to clear"
    echo ""
    swaylock
}

# Quick lock command for binding
quick_lock() {
    swaylock -f
}

# Alternative minimal lock (no indicator)
minimal_lock() {
    swaylock \
        --image /home/pabloagn/.local/share/wallpapers/dante/wallpaper-01.jpg \
        --scaling fill \
        --no-unlock-indicator
}

# Menu
echo "Choose test option:"
echo "1) Basic test with config"
echo "2) Test with explicit flags"
echo "3) Test visual states"
echo "4) Quick lock (forked)"
echo "5) Minimal lock (no indicator)"
echo ""
read -p "Option (1-5): " choice

case $choice in
    1) test_basic ;;
    2) test_explicit ;;
    3) test_states ;;
    4) quick_lock ;;
    5) minimal_lock ;;
    *) echo "Invalid option" ;;
esac
