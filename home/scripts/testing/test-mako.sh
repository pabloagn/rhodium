#!/usr/bin/env bash

# Test script for mako notifications

echo "Starting mako notification tests..."
echo "Make sure mako is running!"
echo ""

# Function to pause between tests
pause() {
    echo "Press Enter to continue to next test..."
    read
}

# Function to send notification and wait
test_notification() {
    local delay=${1:-2}
    sleep $delay
}

echo "=== TESTING URGENCY LEVELS ==="

echo "1. Testing LOW urgency..."
notify-send -u low "Low Priority Task" "This is a low priority notification"
test_notification

echo "2. Testing NORMAL urgency..."
notify-send -u normal "Normal Priority Task" "This is a normal priority notification"
test_notification

echo "3. Testing CRITICAL urgency..."
notify-send -u critical "Critical Alert" "This is a critical notification that won't timeout"
test_notification 3
pause

echo "=== TESTING APPLICATION OVERRIDES ==="

echo "4. Testing Telegram notification..."
notify-send -a "Telegram Desktop" "New Message" "You have a new message from John"
test_notification

echo "5. Testing Discord notification..."
notify-send -a "discord" "Discord Message" "New message in #general"
test_notification

echo "6. Testing Signal notification..."
notify-send -a "Signal" "Signal Message" "Secure message received"
test_notification

echo "7. Testing System notification..."
notify-send -a "notify-send" "System Update" "5 packages can be upgraded"
test_notification

echo "8. Testing Kitty terminal notification..."
notify-send -a "kitty" "Process Complete" "Build finished successfully"
test_notification

echo "9. Testing Alacritty terminal notification..."
notify-send -a "alacritty" "Task Done" "Download completed"
test_notification
pause

echo "=== TESTING SUMMARY PATTERNS ==="

echo "10. Testing Volume notification..."
notify-send "Volume" "75%"
test_notification

echo "11. Testing Volume with different text..."
notify-send "Volume Adjusted" "Volume is now at 50%"
test_notification

echo "12. Testing Brightness notification..."
notify-send "Brightness" "80%"
test_notification

echo "13. Testing Brightness with different text..."
notify-send "Screen Brightness" "Brightness set to 60%"
test_notification

echo "14. Testing Battery notification..."
notify-send "Battery Low" "15% remaining"
test_notification

echo "15. Testing Battery charging..."
notify-send "Battery Charging" "Currently at 45%"
test_notification

echo "16. Testing Network notification..."
notify-send "Network Connected" "Connected to HomeWiFi"
test_notification

echo "17. Testing Wi-Fi notification..."
notify-send "Wi-Fi Signal" "Signal strength: Excellent"
test_notification

echo "18. Testing Download notification..."
notify-send "Download Complete" "firefox-installer.exe downloaded"
test_notification

echo "19. Testing Download in progress..."
notify-send "Download Progress" "45% - Downloading large-file.iso"
test_notification

echo "20. Testing Authentication notification..."
notify-send "Authentication Required" "Please enter your password"
test_notification

echo "21. Testing Device notification..."
notify-send "Device Connected" "USB drive mounted at /media/usb"
test_notification

echo "22. Testing Git notification..."
notify-send "Git Push" "Successfully pushed to origin/main"
test_notification

echo "23. Testing Build notification..."
notify-send "Build Status" "Build completed with 0 errors"
test_notification
pause

echo "=== TESTING MORE APPLICATION OVERRIDES ==="

echo "24. Testing Thunderbird email..."
notify-send -a "thunderbird" "New Email" "From: boss@company.com"
test_notification

echo "25. Testing Flameshot screenshot..."
notify-send -a "flameshot" "Screenshot Saved" "Saved to ~/Pictures/screenshot.png"
test_notification

echo "26. Testing Spectacle screenshot..."
notify-send -a "spectacle" "Screenshot Captured" "Copied to clipboard"
test_notification

echo "27. Testing Calendar notification..."
notify-send -a "gnome-calendar" "Meeting Reminder" "Team standup in 15 minutes"
test_notification

echo "28. Testing Spotify notification..."
notify-send -a "spotify" "Now Playing" "Artist - Song Title"
test_notification

echo "29. Testing Rhythmbox notification..."
notify-send -a "rhythmbox" "Track Changed" "New Song - Cool Band"
test_notification

echo "30. Testing Nautilus file manager..."
notify-send -a "nautilus" "File Operation" "5 files copied successfully"
test_notification

echo "31. Testing Thunar file manager..."
notify-send -a "thunar" "Move Complete" "Files moved to Documents"
test_notification
pause

echo "=== TESTING GROUPED NOTIFICATIONS ==="

echo "32. Testing multiple notifications for grouping..."
echo "Sending 5 similar notifications..."
for i in {1..5}; do
    notify-send "Grouped Message" "This is message number $i"
    sleep 0.5
done
test_notification 3
pause

echo "=== TESTING SPECIAL FEATURES ==="

echo "33. Testing notification with progress..."
# This requires a notification daemon that supports hints
notify-send "File Transfer" "Copying files..." \
    -h int:value:45 \
    -h string:synchronous:volume
test_notification

echo "34. Testing long notification text..."
notify-send "Long Notification" "This is a very long notification text that should wrap properly in the notification window. It contains multiple sentences to test how mako handles text wrapping and formatting with longer content."
test_notification 3

echo "35. Testing notification with markup..."
notify-send "Markup Test" "<b>Bold text</b> and <i>italic text</i> and <u>underlined</u>"
test_notification

echo "36. Testing notification with special characters..."
notify-send "Special Characters" "Test: @#$%^&*()_+-={}[]|\\:;\"'<>,.?/~\`"
test_notification
pause

echo "=== TESTING EDGE CASES ==="

echo "37. Testing empty body..."
notify-send "Title Only" ""
test_notification

echo "38. Testing very short notification..."
notify-send "Hi" "Bye"
test_notification

echo "39. Testing notification with newlines..."
notify-send "Multi-line" "Line 1\nLine 2\nLine 3"
test_notification

echo "40. Testing rapid notifications..."
echo "Sending 3 rapid notifications..."
notify-send "Rapid 1" "First" &
notify-send "Rapid 2" "Second" &
notify-send "Rapid 3" "Third" &
test_notification 3

echo ""
echo "=== ALL TESTS COMPLETE ==="
echo ""
echo "Additional manual tests:"
echo "1. Click notifications with left mouse button (should invoke default action)"
echo "2. Click with middle mouse button (should dismiss)"
echo "3. Click with right mouse button (should dismiss all)"
echo "4. Let a critical notification appear and verify it doesn't timeout"
echo "5. Test sound playback (if you have mpv installed)"
echo ""
echo "To test do-not-disturb mode:"
echo "  makoctl mode -a do-not-disturb  # Hide all notifications"
echo "  makoctl mode -r do-not-disturb  # Show notifications again"
echo ""
echo "To test minimal mode:"
echo "  makoctl mode -a minimal  # Minimal notification style"
echo "  makoctl mode -r minimal  # Normal style again"
