#!/usr/bin/env bash

# Path to the directory containing the scripts
SCRIPT_DIR="/home/pabloagn/.dotfiles/user/desktop/rofi/scripts/executables"

# Prepare the list of titles and descriptions
MENU_ENTRIES=""

for script in "$SCRIPT_DIR"/*.sh; do
    # Extract title (third line) and description (fourth line)
    title=$(sed -n '3s/^# Title: //p' "$script")
    description=$(sed -n '4s/^# Description: //p' "$script")
    
    # Combine title and description in one line, formatted with title and italicized description
		MENU_ENTRIES+="$title (<i>$description</i>)\n"
done

# Show Rofi menu and capture the selected title
chosen=$(echo -e "$MENU_ENTRIES" | rofi -dmenu -markup-rows -theme "/home/pabloagn/.dotfiles/user/desktop/rofi/themes/style-4.rasi" -i -p "Select Script:")

# Find and execute the selected script
if [ -n "$chosen" ]; then
    for script in "$SCRIPT_DIR"/*.sh; do
        # Match the chosen title with the script's title
        title=$(sed -n '3s/^# Title: //p' "$script")
        if [[ "$chosen" == "$title"* ]]; then
            # Execute the script in the background
            nohup bash "$script" &>/dev/null &
            notify-send "Executing: $title"
            break
        fi
    done
else
    notify-send "No script selected"
fi
