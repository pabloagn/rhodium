#!/usr/bin/env bash

# Nerd Fonts Category Extractor for NixOS
# Extract specific font families or generate all categories
#
# Usage:
#   ./generate_nerdfonts_config.sh glyphs.json -c "dev" > glyphs.nix
#   ./generate_nerdfonts_config.sh glyphs.json > all_glyphs.nix

set -euo pipefail

# Check dependencies
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required" >&2
    exit 1
fi

# Parse arguments
JSON_FILE=""
CATEGORY=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--category)
            CATEGORY="$2"
            shift 2
            ;;
        *)
            JSON_FILE="$1"
            shift
            ;;
    esac
done

if [ -z "$JSON_FILE" ]; then
    echo "Usage: $0 <glyphnames.json> [-c|--category <category>]" >&2
    echo "Examples:" >&2
    echo "  $0 glyphs.json -c dev          # Extract only dev icons" >&2
    echo "  $0 glyphs.json                 # Extract all categories" >&2
    exit 1
fi

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: File '$JSON_FILE' not found." >&2
    exit 1
fi

# Function to clean icon name (remove prefix)
clean_name() {
    local name="$1"
    echo "$name" | sed 's/^[^-]*-//' | sed 's/_/-/g'
}

# Function to extract category
extract_category() {
    local prefix="$1"
    echo "  $prefix = {"
    
    # Get all icons for this prefix
    jq -r --arg prefix "$prefix" '
        to_entries[] | 
        select(.key != "METADATA") | 
        select(.key | startswith($prefix + "-")) | 
        "\(.key)|\(.value.char)|\(.value.code)"
    ' "$JSON_FILE" | while IFS='|' read -r full_name char code; do
        clean_icon_name=$(clean_name "$full_name")
        hex_code=$(echo "$code" | tr '[:lower:]' '[:upper:]')
        echo "    $clean_icon_name = { char = \"$char\"; hexCode = \"nf-$hex_code\"; };"
    done
    
    echo "  };"
}

echo "{"

if [ -n "$CATEGORY" ]; then
    # Extract specific category
    # Check if category exists in the available prefixes
    available_prefixes=$(jq -r 'keys[]' "$JSON_FILE" | grep -v "METADATA" | cut -d'-' -f1 | sort | uniq)
    if echo "$available_prefixes" | grep -q "^$CATEGORY$"; then
        extract_category "$CATEGORY"
    else
        echo "Error: Category '$CATEGORY' not found." >&2
        echo "Available categories:" >&2
        echo "$available_prefixes" >&2
        exit 1
    fi
else
    # Extract all categories
    prefixes=$(jq -r 'keys[]' "$JSON_FILE" | grep -v "METADATA" | cut -d'-' -f1 | sort | uniq)
    
    for prefix in $prefixes; do
        extract_category "$prefix"
        echo ""
    done
fi

echo "}"
