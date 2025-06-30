#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Cache builder script - handles actual cache building operations
# Usage: ./cache-builder.sh [options]
#

COMMON_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${COMMON_DIR}/helpers.sh"
source "${COMMON_DIR}/bootstrap.sh"

# --- Variables for fuzzel-apps cache ---
APP_NAME="rhodium-apps"
APP_TITLE="Rhodium's Apps"
PADDING_ARGS="35 20 20" # Column padding: name, type, categories

# --- Function To Build Fuzzel-apps Cache ---
build_fuzzel_cache() {
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

# --- Function To Update Bat Cache ---
update_bat_cache() {
    print_pending "Updating bat cache..."
    if bat cache --build; then
        print_success "Bat cache updated"
    else
        print_error "Failed to update bat cache"
        return 1
    fi
}

# --- Function To Update Tldr Cache ---
update_tldr_cache() {
    print_pending "Updating tldr cache..."
    if tldr --update; then
        print_success "TLDR cache updated"
    else
        print_error "Failed to update tldr cache"
        return 1
    fi
}

# --- Function To Update Unicode Icons Cache ---
update_icons_cache() {
    print_pending "Updating unicode icons cache..."
    if python3 "${COMMON_DIR}/build-icons-cache.py"; then
        print_success "Unicode icons cache updated"
    else
        print_error "Failed to update unicode icons cache"
        return 1
    fi
}

# --- Function To Update Nix Index ---
update_nix_index() {
    print_pending "Updating nix index..."
    if nix-index; then
        print_success "Nix index updated"
    else
        print_error "Failed to update nix index"
        return 1
    fi
}

# --- Usage Function ---
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  --fuzzel, -f          Build fuzzel apps cache"
    echo "  --bat, -b             Update bat syntax cache"
    echo "  --tldr, -t            Update tldr pages cache"
    echo "  --icons, -i           Update unicode icons cache"
    echo "  --nix, -n             Update nix index database"
    echo "  --all, -a             Update all caches"
    echo "  --all-except-nix, -e  Update all caches except nix index"
    echo "  --help, -h            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --fuzzel --bat"
    echo "  $0 -f -b -t"
    echo "  $0 --all"
}

# --- Main Function ---
main() {
    local run_fuzzel=false
    local run_bat=false
    local run_tldr=false
    local run_icons=false
    local run_nix=false
    local has_operations=false

    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
        --fuzzel | -f)
            run_fuzzel=true
            has_operations=true
            shift
            ;;
        --bat | -b)
            run_bat=true
            has_operations=true
            shift
            ;;
        --tldr | -t)
            run_tldr=true
            has_operations=true
            shift
            ;;
        --icons | -i)
            run_icons=true
            has_operations=true
            shift
            ;;
        --nix | -n)
            run_nix=true
            has_operations=true
            shift
            ;;
        --all | -a)
            run_fuzzel=true
            run_bat=true
            run_tldr=true
            run_icons=true
            run_nix=true
            has_operations=true
            shift
            ;;
        --all-except-nix | -e)
            run_fuzzel=true
            run_bat=true
            run_tldr=true
            run_icons=true
            has_operations=true
            shift
            ;;
        --help | -h)
            show_usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
        esac
    done

    # Show usage if no operations specified
    if [[ "$has_operations" == false ]]; then
        show_usage
        exit 1
    fi

    # Execute selected operations
    local failed_operations=()

    [[ "$run_fuzzel" == true ]] && { build_fuzzel_cache || failed_operations+=("fuzzel"); }
    [[ "$run_bat" == true ]] && { update_bat_cache || failed_operations+=("bat"); }
    [[ "$run_tldr" == true ]] && { update_tldr_cache || failed_operations+=("tldr"); }
    [[ "$run_icons" == true ]] && { update_icons_cache || failed_operations+=("icons"); }
    [[ "$run_nix" == true ]] && { update_nix_index || failed_operations+=("nix"); }

    # Report results
    if [[ ${#failed_operations[@]} -eq 0 ]]; then
        print_success "All cache operations completed successfully!"
        exit 0
    else
        print_error "Some operations failed: ${failed_operations[*]}"
        exit 1
    fi
}

main "$@"
