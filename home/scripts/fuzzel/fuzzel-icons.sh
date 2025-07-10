#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-fuzzel-icons"
APP_TITLE="Rhodium's Unicode Collection"
PROMPT="∪: "

# --- Padding Configuration ---
SYMBOL_PADDING=10
NAME_PADDING=60
CATEGORY_PADDING=30

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Variables ---
UNICODE_JSON_FILE="$HOME/.local/share/icons/icons.json"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
CACHE_FILE_FLAT="$CACHE_DIR/flat_symbols.cache"
CACHE_FILE_BLOCKS="$CACHE_DIR/blocks.cache"

# --- Helper Functions ---
usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

A Unicode symbol picker using fuzzel.

Options:
  -f, --file PATH      Path to the JSON Unicode symbols file.
                       (Default: $UNICODE_JSON_FILE)
  -h, --help           Show this help message.
EOF
}

# Check if jq is available
check_dependencies() {
    if ! command -v jq &>/dev/null; then
        notify "$APP_TITLE" "Error: jq is not installed."
        exit 1
    fi
    
    if [[ ! -f "$UNICODE_JSON_FILE" ]]; then
        notify "$APP_TITLE" "Error: Unicode JSON file not found at $UNICODE_JSON_FILE"
        exit 1
    fi
}

# Show flattened view
show_flattened_view() {
    local selected
    selected=$(cut -f1 "$CACHE_FILE_FLAT" | fuzzel --dmenu --prompt "Select symbol: " -w 120)
    
    if [[ -n "$selected" ]]; then
        # Extract symbol from cache
        local symbol
        symbol=$(awk -F'\t' -v sel="$selected" '$1 == sel { print $2; exit }' "$CACHE_FILE_FLAT")
        
        if [[ -n "$symbol" ]]; then
            echo -n "$symbol" | wl-copy
            notify "$APP_TITLE" "Symbol copied to clipboard: $symbol"
        fi
    fi
}

# Show category view for a specific block
show_category_view() {
    local block="$1"
    
    # Get categories and symbols for this block
    local category_data
    category_data=$(jq -r --arg block "$block" '
        .[$block] | to_entries | .[] |
        .key as $category |
        .value[] |
        [$category, .symbol, .name] |
        @tsv
    ' "$UNICODE_JSON_FILE")
    
    # Build formatted entries
    local formatted_entries=""
    while IFS=$'\t' read -r category symbol name; do
        # For category view: symbol, name, category (no block needed)
        local formatted_text=""
        formatted_text+=$(printf "%-*s" "$SYMBOL_PADDING" "$symbol")
        formatted_text+=" "
        formatted_text+=$(printf "%-*s" "$NAME_PADDING" "$name")
        formatted_text+=" "
        formatted_text+="$category"
        
        formatted_entries+="$formatted_text\t$symbol\n"
    done <<< "$category_data"
    
    # Show menu
    local selected
    selected=$(echo -e "$formatted_entries" | cut -f1 | fuzzel --dmenu --prompt "Symbol ($block): " -w 100)
    
    if [[ -n "$selected" ]]; then
        # Extract symbol
        local symbol
        symbol=$(echo -e "$formatted_entries" | awk -F'\t' -v sel="$selected" '$1 == sel { print $2; exit }')
        
        if [[ -n "$symbol" ]]; then
            echo -n "$symbol" | wl-copy
            notify "$APP_TITLE" "Symbol copied to clipboard: $symbol"
        fi
    fi
}

# Browse by category (hierarchical)
browse_by_category() {
    # Select block
    local selected_block
    selected_block=$(cat "$CACHE_FILE_BLOCKS" | fuzzel --dmenu --prompt "Block: ")
    
    if [[ -n "$selected_block" ]]; then
        show_category_view "$selected_block"
    fi
}

# Main logic
main() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
        -f | --file)
            UNICODE_JSON_FILE="$2"
            shift 2
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
        esac
    done

    # Pre-flight checks
    check_dependencies

    # Main menu options
    local main_menu_options
    main_menu_options=$(
        cat <<EOF
⊹ By Category
⊹ Flattened View
EOF
    )

    local num_main_options
    num_main_options=$(echo -e "$main_menu_options" | wc -l)

    local choice
    choice=$(echo -e "$main_menu_options" | fuzzel --dmenu --prompt="$PROMPT" -l "$num_main_options") || exit 0

    case "$choice" in
    "⊹ By Category") browse_by_category ;;
    "⊹ Flattened View") show_flattened_view ;;
    *)
        notify "$APP_TITLE" "Invalid option selected: $choice"
        ;;
    esac
}

# Pass all script arguments to the main function
main "$@"
