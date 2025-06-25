#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-unicode"
APP_TITLE="Rhodium's Unicode Collection"
PROMPT="β: "

# --- Padding Configuration ---
SYMBOL_PADDING=10
NAME_PADDING=60  # Much larger to accommodate long names
CATEGORY_PADDING=30  # For combined "Block > Category"

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

# Build cache files
build_cache() {
    mkdir -p "$CACHE_DIR"
    
    # Extract all data in one jq call
    local json_data
    json_data=$(jq -r '
        to_entries | .[] | 
        .key as $block | 
        .value | to_entries | .[] | 
        .key as $category | 
        .value[] | 
        [$block, $category, .symbol, .name] | 
        @tsv
    ' "$UNICODE_JSON_FILE")
    
    # Build flattened cache
    {
        while IFS=$'\t' read -r block category symbol name; do
            # Build formatted text - 3 columns: symbol, name, "block > category"
            local formatted_text=""
            formatted_text+=$(printf "%-*s" "$SYMBOL_PADDING" "$symbol")
            formatted_text+=" "
            formatted_text+=$(printf "%-*s" "$NAME_PADDING" "$name")
            formatted_text+=" "
            formatted_text+="$block > $category"
            
            # Store formatted text and symbol separated by tab
            printf '%s\t%s\n' "$formatted_text" "$symbol"
        done <<< "$json_data" | sort -k1,1
    } > "$CACHE_FILE_FLAT"
    
    # Build blocks cache (unique blocks)
    jq -r 'keys[]' "$UNICODE_JSON_FILE" | sort > "$CACHE_FILE_BLOCKS"
}


# build_cache() {
#     mkdir -p "$CACHE_DIR"
#
#     SYMBOL_PADDING=${SYMBOL_PADDING:-4}
#     NAME_PADDING=${NAME_PADDING:-20}
#
#     # Use Python to measure visual display width
#     display_width() {
#         python3 -c "from wcwidth import wcswidth; print(wcswidth('$1'))"
#     }
#
#     # Truncate string to a max visual width with ellipsis
#     truncate_visual() {
#         local str="$1"
#         local max_width="$2"
#         local ellipsis="..."
#         local result=""
#         local total=0
#         local char width
#
#         while IFS= read -r -n1 char; do
#             width=$(python3 -c "from wcwidth import wcwidth; print(wcwidth('$char'))")
#             [[ $width -lt 0 ]] && width=0
#             (( total + width > max_width - 3 )) && break
#             result+="$char"
#             (( total += width ))
#         done <<< "$str"
#
#         local final_width
#         final_width=$(python3 -c "from wcwidth import wcswidth; print(wcswidth('$result'))")
#         local padding=$(( max_width - final_width ))
#
#         if [[ $total -lt $(display_width "$str") ]]; then
#             printf "%s%s" "$result" "..."
#         else
#             printf "%s%*s" "$result" "$padding" ""
#         fi
#     }
#
#     local json_data
#     json_data=$(jq -r '
#         to_entries | .[] |
#         .key as $block |
#         .value | to_entries | .[] |
#         .key as $category |
#         .value[] |
#         [$block, $category, .symbol, .name] |
#         @tsv
#     ' "$UNICODE_JSON_FILE")
#
#     {
#         while IFS=$'\t' read -r block category symbol name; do
#             local formatted_text=""
#             formatted_text+=$(truncate_visual "$symbol" "$SYMBOL_PADDING")
#             formatted_text+=" "
#             formatted_text+=$(truncate_visual "$name" "$NAME_PADDING")
#             formatted_text+=" "
#             formatted_text+="$block > $category"
#
#             printf '%s\t%s\n' "$formatted_text" "$symbol"
#         done <<< "$json_data" | sort -k1,1
#     } > "$CACHE_FILE_FLAT"
#
#     jq -r 'keys[]' "$UNICODE_JSON_FILE" | sort > "$CACHE_FILE_BLOCKS"
# }

# Check if cache needs rebuild
cache_needs_rebuild() {
    [[ ! -f "$CACHE_FILE_FLAT" ]] || \
    [[ ! -f "$CACHE_FILE_BLOCKS" ]] || \
    [[ "$UNICODE_JSON_FILE" -nt "$CACHE_FILE_FLAT" ]]
}

# Show flattened view
show_flattened_view() {
    if cache_needs_rebuild; then
        build_cache
    fi
    
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
    if cache_needs_rebuild; then
        build_cache
    fi
    
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
