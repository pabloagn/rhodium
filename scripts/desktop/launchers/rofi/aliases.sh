#!/usr/bin/env bash

# scripts/desktop/launchers/rofi/aliases.sh

ALIASES_FILE="$DOTUSER/term/aliases.nix"

# Extract aliases from the Nix file
aliases=$(grep -oP '(?<=").*(?=")' "$ALIASES_FILE" | sed 's/ = /\t/')

# Display aliases in Rofi
selected=$(echo "$aliases" | rofi -dmenu -i -p "Aliases")

# Copy the selected alias to clipboard
if [ -n "$selected" ]; then
    echo "$selected" | cut -f2 | wc -c | xargs -I {} head -c -{} <<< "$selected" | cut -f2 | xclip -selection clipboard
fi
