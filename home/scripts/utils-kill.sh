#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-util-kill"
APP_TITLE="Memento Mori"

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/shared-functions.sh" ]]; then
    source "$SCRIPT_DIR/shared-functions.sh"
else
    echo "Error: shared-functions.sh not found" >&2
    exit 1
fi

# Pick a window to kill
focused=$(niri msg --json pick-window)

# Check if user escaped
if [[ "$focused" == "null" ]]; then
    notify "$APP_TITLE" "We Shall Forgive Tonight" >&2
    exit 0
fi

# Extract the PID
pid=$(echo "$focused" | jq -r '.pid')
app=$(echo "$focused" | jq -r '.app_id')

# Kill it immediately
if [[ "$pid" != "null" && -n "$pid" ]]; then
    kill -9 "$pid"
    notify "$APP_TITLE" "Blood Was Spilled\n◌ Victim: $app\n◌ PID: $pid" >&2
else
    notify "$APP_TITLE" "No valid PID found for focused window" >&2
    exit 1
fi
