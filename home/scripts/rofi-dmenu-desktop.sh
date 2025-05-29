#!/usr/bin/env bash

PREFIX="firefox"
PATTERN="^(${PREFIX}).*(\.desktop)$"
APP_DIR="$HOME/.nix-profile/share/applications/"

if ! command -v fd &> /dev/null; then
    rofi -e "Error: fd command not found. Please install fd."
    exit 1
fi

options=$(fd "$PATTERN" "$APP_DIR"  2>/dev/null | \
    while IFS= read -r filepath; do
        filename=$(basename "$filepath")
        display_name=$(rg -m 1 "^Name=" "$filepath" | sed 's/^Name=//')
        [ -z "$display_name" ] && display_name="$filename"
        echo "$display_name ($filename)"
    done | sort)

if [ -z "$options" ]; then
    rofi -e "No apps found for prefix '${PREFIX}' in ${APP_DIR} using fd"
    exit 1
fi

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Launch (${PREFIX})")

if [ -n "$chosen" ]; then
    app_to_launch=$(echo "$chosen" | sed 's/.*(\(.*\))$/\1/')
    gtk-launch "$app_to_launch" >/dev/null 2>&1 &
fi
