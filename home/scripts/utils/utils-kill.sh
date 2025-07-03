#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-util-kill"
APP_TITLE="Memento Mori"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# Pick a window to kill
notify "$APP_TITLE" "Knives Out" >&2
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
