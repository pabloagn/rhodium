#!/usr/bin/env bash

# Toggle special workspace script
# Usage: toggle-special-workspace.sh [workspace-name] [program-to-start]

WORKSPACE_NAME="$1"
PROGRAM="$2"

# Check if program is running
if pgrep -f "$PROGRAM" > /dev/null; then
    # Program is running, toggle the workspace
    hyprctl dispatch togglespecialworkspace "$WORKSPACE_NAME"
else
    # Program is not running, start it in the special workspace
    hyprctl dispatch workspace special:"$WORKSPACE_NAME"
    hyprctl dispatch exec "$PROGRAM"
fi
