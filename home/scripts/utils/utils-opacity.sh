#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-util-opacity"
APP_TITLE="Rhodium's Opacity"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# Pick a window to change opacity
notify "$APP_TITLE" "Toggle Opacity" >&2
focused=$(niri msg --json pick-window)

# Check if user escaped
if [[ "$focused" == "null" ]]; then
    notify "$APP_TITLE" "Opacity Change Aborted" >&2
    exit 0
fi

# Extract the app ID
app_id=$(echo "$focused" | jq -r '.id')
app_name=$(echo "$focused" | jq -r '.app_id')
niri msg action focus-window --id "$app_id"
niri msg action toggle-window-rule-opacity
notify "$APP_TITLE" "Toggled Opacity\n◌ ID: $app_id\n◌ App: $app_name" >&2
exit 1
