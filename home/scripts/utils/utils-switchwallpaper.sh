#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/wallpapers"
THUMB_DIR="$WALLPAPER_DIR/.thumbs"

# -- fallback: ensure wallpaper directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
  echo "⚠ Wallpaper directory not found: $WALLPAPER_DIR"
  exit 1
fi

# -- pick image from thumbnail names
selected=$(find "$THUMB_DIR" -type f -iname '*.webp' -print0 | sort -z | fuzzel --dmenu -p "Wallpaper" --no-terminal | tr -d '\0')

# -- fallback: user canceled selection
if [[ -z "${selected:-}" ]]; then
  echo "No wallpaper selected. Aborting."
  exit 0
fi

# -- resolve selected thumbnail to original image
basename=$(basename "$selected" .webp)
original_jpg="$WALLPAPER_DIR/${basename}.jpg"
original_png="$WALLPAPER_DIR/${basename}.png"

# -- fallback: validate original exists
if [[ -f "$original_jpg" ]]; then
  fullpath="$original_jpg"
elif [[ -f "$original_png" ]]; then
  fullpath="$original_png"
else
  echo "❌ Could not find original wallpaper for: $basename"
  exit 1
fi

# -- set environment for rh-swaybg systemd service
systemctl --user set-environment WALLPAPER="$fullpath"
systemctl --user restart rh-swaybg.service

echo "✓ Wallpaper switched to: $fullpath"

