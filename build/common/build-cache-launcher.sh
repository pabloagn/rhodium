#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Cache builder script for launcher
#

COMMON_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${COMMON_DIR}/helpers.sh"
source "${COMMON_DIR}/bootstrap.sh"

# --- Variables for fuzzel-apps cache ---
APP_NAME="rhodium-apps"
APP_TITLE="Rhodium's Apps"
PADDING_ARGS="35 20 20" # Column padding: name, type, categories

# --- Function To Build Fuzzel-apps Cache ---
build_cache_launcher() {
    local APP_DIR="$HOME/.local/share/applications"
    local CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
    local CACHE_FILE="$CACHE_DIR/formatted_apps.cache"

    print_pending "Building fuzzel-apps cache..."

    # Create cache directory
    mkdir -p "$CACHE_DIR"

    # Parse padding arguments
    local -a paddings
    read -ra paddings <<<"$PADDING_ARGS"

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

    print_success "Fuzzel-apps cache built"
}

