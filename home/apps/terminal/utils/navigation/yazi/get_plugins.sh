#!/usr/bin/env bash

# ---------------------------------------------------------
# Route:............/user/term/yazi/get_plugins.sh
# Type:.............Module
# Created by:.......Pablo Aguirre
# ---------------------------------------------------------

# Define the target directory
TARGET_DIR="/home/pabloagnck/.config/yazi/plugins"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# List of repositories to clone
REPOS=(
    "https://github.com/Reledia/miller.yazi"
    "https://github.com/ndtoan96/ouch.yazi"
    "https://github.com/Sonico98/exifaudio.yazi"
    "https://github.com/Reledia/glow.yazi"
    "https://github.com/Reledia/hexyl.yazi"
    "https://github.com/AnirudhG07/nbpreview.yazi"
)

# Clone each repository
for REPO in "${REPOS[@]}"; do
    git clone "$REPO" "$TARGET_DIR/$(basename "$REPO" .yazi)"
done

echo "Repositories cloned into $TARGET_DIR"
