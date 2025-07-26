#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "help"

CONFIG_FILE="$XDG_CONFIG_HOME/niri/config.kdl"

[[ ! -f "$CONFIG_FILE" ]] && {
  notify "$APP_TITLE" "Config not found"
  exit 1
}

# Grep & sed to extract keybinds, exclude comments
grep -v '^[[:space:]]*//' "$CONFIG_FILE" |
  grep 'hotkey-overlay-title=' |
  sed -E 's/^[[:space:]]*([^[:space:]]+)[[:space:]]+[^"]*hotkey-overlay-title="([^"]+)".*/\1|\2/' |
  while IFS='|' read -r keybind title; do
    printf "%-40s %s\n" "$keybind" "$title"
  done |
  sort |
  fuzzel --dmenu --prompt="$PROMPT" -w 85
