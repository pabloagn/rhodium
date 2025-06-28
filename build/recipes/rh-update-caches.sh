#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script updates application caches interactively
#

# SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${SCRIPT_DIR}/rh-helpers.sh"
source "${COMMON_DIR}/bootstrap.sh"

# --- Variables for fuzzel-apps cache ---
APP_NAME="rhodium-apps"
APP_TITLE="Rhodium's Apps"
PADDING_ARGS="35 20 20" # Column padding: name, type, categories

# Function to build fuzzel-apps cache
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

# Function to update bat cache
update_bat_cache() {
    print_pending "Updating bat cache..."
    if bat cache --build; then
        print_success "Bat cache updated"
    else
        print_error "Failed to update bat cache"
    fi
}

# Function to update tldr cache
update_tldr_cache() {
    print_pending "Updating tldr cache..."
    if tldr --update; then
        print_success "TLDR cache updated"
    else
        print_error "Failed to update tldr cache"
    fi
}

# Function to update unicode icons cache
update_icons_cache() {
    print_pending "Updating unicode icons cache..."
    if python3 "${COMMON_DIR}/build-icons-cache.py"; then
        print_success "Unicode icons cache updated"
    else
        print_error "Failed to update unicode icons cache"
    fi
}

# Function to update nix index
update_nix_index() {
    print_pending "Updating nix index..."
    if nix-index; then
        print_success "Nix index updated"
    else
        print_error "Failed to update nix index"
    fi
}

# Interactive menu function
show_menu() {
    echo ""
    print_header "Select caches to update:"
    echo ""
    echo "  1) Fuzzel Apps Cache"
    echo "  2) Bat Syntax Cache"
    echo "  3) TLDR Pages Cache"
    echo "  4) Unicode Icons Cache"
    echo "  5) Nix Index Database"
    echo "  6) All Caches"
    echo "  7) All except Nix Index"
    echo "  0) Exit"
    echo ""
}

# Main function
main() {
    local selections=()
    local choice
    
    while true; do
        show_menu
        read -rp "Enter your choices (space-separated, e.g., '1 3 4'): " -a choices
        
        # Validate input
        local valid=true
        for choice in "${choices[@]}"; do
            if ! [[ "$choice" =~ ^[0-7]$ ]]; then
                print_error "Invalid choice: $choice"
                valid=false
                break
            fi
        done
        
        if [[ "$valid" == true ]]; then
            # Check for exit
            for choice in "${choices[@]}"; do
                if [[ "$choice" == "0" ]]; then
                    print_info "Exiting..."
                    exit 0
                fi
            done
            
            # Process selections
            selections=("${choices[@]}")
            break
        fi
    done
    
    echo ""
    print_pending "Starting cache updates..."
    echo ""
    
    # Execute selected updates
    for choice in "${selections[@]}"; do
        case "$choice" in
            1) build_fuzzel_cache ;;
            2) update_bat_cache ;;
            3) update_tldr_cache ;;
            4) update_icons_cache ;;
            5) update_nix_index ;;
            6) 
                build_fuzzel_cache
                update_bat_cache
                update_tldr_cache
                update_icons_cache
                update_nix_index
                ;;
            7)
                build_fuzzel_cache
                update_bat_cache
                update_tldr_cache
                update_icons_cache
                ;;
        esac
    done
    
    echo ""
    print_success "Cache updates completed!"
}

main "$@"
