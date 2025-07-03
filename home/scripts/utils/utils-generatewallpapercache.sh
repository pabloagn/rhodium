#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/wallpapers"
THUMB_DIR="${WALLPAPER_DIR}/.thumbs"

mkdir -p "$THUMB_DIR"

find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | while read -r img; do
  thumb="$THUMB_DIR/$(basename "$img").webp"
  if [ ! -f "$thumb" ]; then
    convert "$img" -resize 512x288 "$thumb"
  fi
done
