#!/usr/bin/env bash

set -euo pipefail

CONFIG_FILE="$HOME/.config/niri/config.kdl"

[[ ! -f "$CONFIG_FILE" ]] && { notify-send "Error" "Config not found"; exit 1; }

# Simple grep and sed to extract keybinds
grep 'hotkey-overlay-title=' "$CONFIG_FILE" | 
sed -E 's/^[[:space:]]*([^[:space:]]+[^{]*)[[:space:]]+hotkey-overlay-title="([^"]+)".*/\1|\2/' |
while IFS='|' read -r keybind title; do
    printf "%-25s %s\n" "$keybind" "$title"
done | 
sort | 
fuzzel --dmenu --prompt "Keybinds: " --width 80
