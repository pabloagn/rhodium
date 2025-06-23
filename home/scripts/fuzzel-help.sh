#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-keybinds"
APP_TITLE="Rhodium's Keybinds Viewer"
PROMPT="β: "

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/shared-functions.sh" ]]; then
    source "$SCRIPT_DIR/shared-functions.sh"
else
    echo "Error: shared-functions.sh not found" >&2
    exit 1
fi

CONFIG_FILE="$HOME/.config/niri/config.kdl"

[[ ! -f "$CONFIG_FILE" ]] && { notify "$APP_TITLE" "Config not found"; exit 1; }

# Simple grep and sed to extract keybinds, exclude comments
grep -v '^[[:space:]]*//' "$CONFIG_FILE" | 
grep 'hotkey-overlay-title=' | 
sed -E 's/^[[:space:]]*([^[:space:]]+)[[:space:]]+[^"]*hotkey-overlay-title="([^"]+)".*/\1|\2/' |
while IFS='|' read -r keybind title; do
    printf "%-40s %s\n" "$keybind" "$title"
done | 
sort | 
fuzzel --dmenu --prompt="$(provide_fuzzel_prompt)" -w 85
