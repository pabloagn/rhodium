#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-screenshot-annotate"
APP_TITLE="Rh Screenshot Annotate"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# Check dependencies
dependencies=("slurp" "grim" "satty")
for dep in "${dependencies[@]}"; do
    command -v "$dep" &>/dev/null || {
        echo "$dep not found, please install it."
        exit 1
    }
done

# Set output path with timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
output_dir="$HOME/pictures/screenshots"
mkdir -p "$output_dir"
output_path="$output_dir/screenshot_$timestamp.png"

# Select area
area=$(slurp)
[ -z "$area" ] && exit 1

# Capture and edit screenshot
grim -g "$area" - | satty --filename - --output-filename "$output_path" --initial-tool "brush" --copy-command "wl-copy" --action-on-enter "save-to-file" --disable-notifications --early-exit

# Copy to clipboard
wl-copy < "$output_path"

# Send notification with image icon
notify "$APP_TITLE" "Saved and copied to clipboard" -i "$output_path"
