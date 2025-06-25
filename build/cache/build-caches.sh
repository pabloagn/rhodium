#!/usr/bin/env bash

set -euo pipefail

# --- Variables ---
APP_NAME="rhodium-apps"
APP_TITLE="Rhodium's Apps"

# --- Configuration ---
PADDING_ARGS="35 20 20" # Column padding: name, type, categories

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

build_cache() {
    APP_DIR="$HOME/.local/share/applications"
    CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
    CACHE_FILE="$CACHE_DIR/formatted_apps.cache"

    # Create cache directory
    mkdir -p "$CACHE_DIR"

    # Check if cache needs rebuild (if any desktop file is newer than cache)
    # Parse padding arguments
    local -a paddings
    read -ra paddings <<<"$PADDING_ARGS"

    local names=()
    local files=()

    # Parse all desktop files in a single pass
    declare -A name_map type_map cat_map

    # Read all desktop files once and extract all fields
    for file in "$APP_DIR"/rh-*.desktop; do
        [[ -f "$file" ]] || continue

        # Parse the file in a single pass
        while IFS='=' read -r key value; do
            case "$key" in
            "Name")
                name_map["$file"]="$value"
                ;;
            "X-Entry-Type")
                type_map["$file"]="$value"
                ;;
            "X-Category")
                cat_map["$file"]="$value"
                ;;
            esac
        done <"$file"
    done

    # Sort files by name
    readarray -t sorted_files < <(
        for file in "${!name_map[@]}"; do
            printf '%s\t%s\n' "${name_map[$file]}" "$file"
        done | sort -k1,1 | cut -f2
    )

    # Build cache file in sorted order
    {
        for file in "${sorted_files[@]}"; do
            name="${name_map[$file]}"
            entry_type="${type_map[$file]:-app}"

            # Parse and format categories
            categories="${cat_map[$file]:-}"
            if [[ -n "$categories" ]]; then
                # Split by semicolon, capitalize each, join with comma
                IFS=';' read -ra cat_array <<<"$categories"
                formatted_cats=""
                for cat in "${cat_array[@]}"; do
                    # Trim whitespace and capitalize
                    cat="${cat#"${cat%%[![:space:]]*}"}"
                    cat="${cat%"${cat##*[![:space:]]}"}"
                    [[ -n "$cat" ]] && formatted_cats+="${formatted_cats:+, }${cat^}"
                done
                categories="$formatted_cats"
            else
                categories="App"
            fi

            # Build padded entry
            local formatted_text=""
            local parts=("$(provide_fuzzel_entry) $name" "${entry_type^}" "$categories")
            local num_parts=${#parts[@]}
            local num_paddings=${#paddings[@]}

            for ((i = 0; i < num_parts; i++)); do
                local part="${parts[i]}"

                if ((i < num_paddings)); then
                    local pad_to=${paddings[i]}
                    formatted_text+=$(printf "%-*s" "$pad_to" "$part")
                else
                    formatted_text+="$part"
                fi

                if ((i < num_parts - 1)); then
                    formatted_text+=" "
                fi
            done

            # Store formatted line and filename separated by tab
            printf '%s\t%s\n' "$formatted_text" "$file"
        done
    } >"$CACHE_FILE"
}

main() {
    build_cache
}

main
