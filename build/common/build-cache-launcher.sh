#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Cache builder script for launcher
#

COMMON_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${COMMON_DIR}/helpers.sh"
source "${COMMON_DIR}/bootstrap.sh"

# --- Variables for fuzzel-launcher cache ---
APP_NAME="rh-launch"
APP_TITLE="Rhodium's Launcher"
PADDING_ARGS="35 20 20" # Column padding: name, type, categories

# --- Function To Build Fuzzel-launcher Cache ---
build_cache_launcher() {
    local CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
    local CACHE_FILE="$CACHE_DIR/formatted_apps.cache"
    
    print_pending "Building fuzzel-launcher cache..."
    
    # Create cache directory
    mkdir -p "$CACHE_DIR"
    
    # Parse padding arguments
    local -a paddings
    read -ra paddings <<<"$PADDING_ARGS"
    
    # Get XDG data directories
    local data_dirs=()
    if [[ -n "$XDG_DATA_HOME" ]]; then
        data_dirs+=("$XDG_DATA_HOME")
    else
        data_dirs+=("$HOME/.local/share")
    fi
    
    if [[ -n "$XDG_DATA_DIRS" ]]; then
        IFS=':' read -ra system_dirs <<< "$XDG_DATA_DIRS"
        data_dirs+=("${system_dirs[@]}")
    else
        data_dirs+=("/usr/local/share" "/usr/share")
    fi
    
    # Find all desktop files (excluding rh-*)
    local desktop_files=()
    for dir in "${data_dirs[@]}"; do
        if [[ -d "$dir/applications" ]]; then
            while IFS= read -r file; do
                # Skip files starting with rh-
                [[ "$(basename "$file")" =~ ^rh- ]] && continue
                desktop_files+=("$file")
            done < <(find "$dir/applications" -name "*.desktop" 2>/dev/null)
        fi
    done
    
    # Remove duplicates (prefer user files over system)
    declare -A seen_basenames
    local unique_files=()
    for file in "${desktop_files[@]}"; do
        basename_file=$(basename "$file")
        if [[ ! -v "seen_basenames[$basename_file]" ]]; then
            seen_basenames[$basename_file]=1
            unique_files+=("$file")
        fi
    done
    
    # Parse all desktop files
    declare -A name_map generic_map cat_map hidden_map nodisplay_map
    
    for file in "${unique_files[@]}"; do
        [[ -f "$file" ]] || continue
        
        # Parse the file in a single pass
        while IFS='=' read -r key value; do
            case "$key" in
                "Name")
                    name_map["$file"]="$value"
                    ;;
                "GenericName")
                    generic_map["$file"]="$value"
                    ;;
                "Categories")
                    cat_map["$file"]="$value"
                    ;;
                "Hidden")
                    hidden_map["$file"]="$value"
                    ;;
                "NoDisplay")
                    nodisplay_map["$file"]="$value"
                    ;;
            esac
        done < <(grep -E "^(Name|GenericName|Categories|Hidden|NoDisplay)=" "$file")
    done
    
    # Filter out hidden/nodisplay entries and sort by name
    declare -A filtered_files
    for file in "${!name_map[@]}"; do
        # Skip if Hidden=true or NoDisplay=true
        [[ "${hidden_map[$file]:-}" == "true" ]] && continue
        [[ "${nodisplay_map[$file]:-}" == "true" ]] && continue
        [[ -z "${name_map[$file]:-}" ]] && continue
        
        filtered_files["${name_map[$file]}"]="$file"
    done
    
    # Sort by name
    readarray -t sorted_names < <(printf '%s\n' "${!filtered_files[@]}" | sort -f)
    
    # Build cache file
    {
        for name in "${sorted_names[@]}"; do
            file="${filtered_files[$name]}"
            
            # Determine type based on GenericName or Categories
            generic_name="${generic_map[$file]:-}"
            entry_type="Application"
            if [[ -n "$generic_name" ]]; then
                entry_type="$generic_name"
            fi
            
            # Parse and format categories
            categories="${cat_map[$file]:-}"
            if [[ -n "$categories" ]]; then
                # Take first few categories, remove trailing semicolons
                IFS=';' read -ra cat_array <<< "$categories"
                formatted_cats=""
                count=0
                for cat in "${cat_array[@]}"; do
                    # Skip empty entries and technical categories
                    [[ -z "$cat" ]] && continue
                    [[ "$cat" =~ ^(GTK|Qt|KDE|GNOME|X-) ]] && continue
                    
                    formatted_cats+="${formatted_cats:+, }$cat"
                    ((++count >= 3)) && break  # Limit to 3 categories
                done
                categories="${formatted_cats:-Misc}"
            else
                categories="Misc"
            fi
            
            # Build padded entry
            local formatted_text=""
            local parts=("$(provide_fuzzel_entry) $name" "$entry_type" "$categories")
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
    } > "$CACHE_FILE"
    
    print_success "Fuzzel-launcher cache built (${#sorted_names[@]} apps)"
}

# Run the cache builder
build_cache_launcher
