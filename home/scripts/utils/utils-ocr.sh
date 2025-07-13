#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-util-screen-ocr"
APP_TITLE="Rh Screenshot OCR"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# Check dependencies
dependencies=("slurp" "grim" "tesseract")
for dep in "${dependencies[@]}"; do
    command -v "$dep" &>/dev/null || {
        notify "$APP_TITLE" "$dep not found, please install it." -u critical
        exit 1
    }
done

# Create OCR directory if it doesn't exist
ocr_dir="$HOME/pictures/ocr"
mkdir -p "$ocr_dir"

# Generate timestamp for filename
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
ocr_file="$ocr_dir/ocr_$timestamp.txt"

# Create temporary file for screenshot
temp_screenshot=$(mktemp --suffix=.png)

# Select area and capture screenshot
area=$(slurp)
[ -z "$area" ] && exit 1

grim -g "$area" "$temp_screenshot"

# Check if screenshot was taken successfully
if [ $? -eq 0 ] && [ -f "$temp_screenshot" ]; then
    # Perform OCR using tesseract
    tesseract "$temp_screenshot" stdout >"$ocr_file"

    # Check if OCR was successful
    if [ $? -eq 0 ]; then
        # Send success notification
        notify "$APP_TITLE" "OCR completed and saved to $ocr_file" -i "$temp_screenshot"
    else
        notify "$APP_TITLE" "OCR failed" -u critical
    fi

    # Clean up temporary screenshot file
    rm "$temp_screenshot"
else
    notify "$APP_TITLE" "Screenshot capture failed or cancelled" -u critical
    rm -f "$temp_screenshot"
fi
