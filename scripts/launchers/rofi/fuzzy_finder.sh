#!/usr/bin/env bash

# --------------------------------------------------------
# fuzzy_finder.sh - Enhanced fuzzy file finder for NixOS
# --------------------------------------------------------

# --- Configuration ---
THEME_PATH="${HOME}/.dotfiles/user/desktop/rofi/themes/"
# Quote the placeholders within the EDITOR string for robustness with eval
EDITOR="kitty --directory \"\$(dirname '{}')\" nvim '{}'"
DEFAULT_SEARCH_DIR="${HOME}"
MAX_DEPTH=10
# Use an array for exclusions for easier handling
EXCLUDE_DIRS=(".git" "node_modules" ".cache" ".npm" ".pnpm" ".Trash" ".local/share/Trash" "*/__pycache__/*") # Added __pycache__ example
EXCLUDE_FILES=("*.o" "*.so" "*.pyc" "*.pyo")
RECENT_FILES_MAX=20
RECENT_FILES_PATH="${HOME}/.cache/fuzzy_finder_history"
CACHE_DIR="${HOME}/.cache/fuzzy_finder"
CACHE_TIMEOUT=3600  # Cache timeout in seconds (1 hour)

# --- Setup ---
mkdir -p "$CACHE_DIR"
mkdir -p "$(dirname "$RECENT_FILES_PATH")"
touch "$RECENT_FILES_PATH"

# --- Functions ---

# Notification function
notify() {
    notify-send "Fuzzy Finder" "$1" -a "Fuzzy Finder"
}

# Check if required tools are installed
check_dependencies() {
    local missing_deps=()
    # Removed 'find' from check as it's usually built-in
    for cmd in rofi wl-copy notify-send bat; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            # Allow bat to be optional for preview
            if [[ "$cmd" == "bat" ]]; then
                echo "Warning: 'bat' not found, preview will use 'head'."
            else
                missing_deps+=("$cmd")
            fi
        fi
    done

    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo "Error: Missing dependencies: ${missing_deps[*]}"
        notify "Error: Missing dependencies: ${missing_deps[*]}"
        exit 1
    fi
}

# File preview function (Defined but not used by default rofi dmenu)
# To use this, you'd need rofi script mode or similar.
generate_preview() {
    local file="$1"
    local preview_width=80 # Consider getting terminal width: $(tput cols)
    local preview_height=20

    # Basic check for binary data (heuristic)
    if grep -qI "$file"; then # -I ignores binary files
        if command -v bat >/dev/null 2>&1; then
            bat --color=always --style=numbers --line-range=:$preview_height --terminal-width=$preview_width "$file" 2>/dev/null || head -n $preview_height "$file"
        else
            head -n $preview_height "$file"
        fi
    else
       echo "Binary file: $(file -b --mime-type "$file")"
    fi
}
# Export the function so subshells (like rofi's preview) can potentially use it
export -f generate_preview

# Get recently used files
get_recent_files() {
    if [ -f "$RECENT_FILES_PATH" ]; then
        # Ensure awk doesn't mangle paths with spaces, read line by line
        # Also, filter out non-existent files from recent list
        local temp_recent_file
        while IFS= read -r temp_recent_file; do
            if [[ -f "$temp_recent_file" ]]; then
                echo "$temp_recent_file"
            fi
        done < <(awk '!seen[$0]++' "$RECENT_FILES_PATH" | head -n "$RECENT_FILES_MAX")
    fi
}

# Add file to recent files list
add_to_recent_files() {
    local file="$1"
    # Ensure file exists before adding
    if [[ ! -f "$file" ]]; then
        return
    fi

    # Use temporary file for atomic update (more robust)
    local temp_file
    temp_file=$(mktemp)
    echo "$file" > "$temp_file"
    if [ -f "$RECENT_FILES_PATH" ]; then
        cat "$RECENT_FILES_PATH" >> "$temp_file"
    fi
    # awk unique and head limit, then replace original
    awk '!seen[$0]++' "$temp_file" | head -n "$RECENT_FILES_MAX" > "$RECENT_FILES_PATH"
    rm "$temp_file"
}

# Get cached file list or generate new one
get_file_list() {
    local search_dir="$1"
    # Use a more robust cache filename (handles non-ASCII better potentially)
    local cache_key
    cache_key=$(printf "%s" "$search_dir" | md5sum | cut -d' ' -f1)
    local cache_file="$CACHE_DIR/$cache_key"

    # Check if cache exists and is fresh
    if [ -f "$cache_file" ]; then
        local cache_age=$(( $(date +%s) - $(stat -c %Y "$cache_file") ))
        if [ $cache_age -lt $CACHE_TIMEOUT ]; then
            cat "$cache_file"
            return 0 # Success
        fi
    fi

    # Build find command arguments dynamically using an array
    local find_args=("$search_dir")

    # Prune excluded directories (more efficient than checking path later)
    # Also handle hidden directories generally, but allow specific hidden files/dirs if needed
    find_args+=(-name .git -prune -o -name node_modules -prune -o -name .cache -prune -o -name .npm -prune -o -name .pnpm -prune -o -name .Trash -prune -o -path '*/__pycache__/*' -prune)

    # Add other standard exclusions
    find_args+=(-o -maxdepth "$MAX_DEPTH" -type f) # Apply maxdepth only after pruning

    # Add file name exclusions
    for file_pattern in "${EXCLUDE_FILES[@]}"; do
        find_args+=(-not -name "$file_pattern")
    done

    # Add the print action
    find_args+=(-print)

    echo "Generating file list for $search_dir (this may take a moment)..." >&2

    # Execute find, redirect errors, sort, and cache
    # Use process substitution to avoid temporary file for sort if possible, handle errors
    if find "${find_args[@]}" 2>/dev/null | sort > "$cache_file"; then
       cat "$cache_file"
    else
       # Find command failed, remove potentially incomplete cache file
       rm -f "$cache_file"
       notify "Error generating file list for $search_dir"
       return 1 # Failure
    fi
}


# Find files and filter through rofi
find_files() {
    local search_dir="${1:-$DEFAULT_SEARCH_DIR}"
    search_dir=$(realpath "$search_dir") # Resolve to absolute path

    # Get file lists, handle potential error from get_file_list
    local recent_files
    recent_files=$(get_recent_files) || recent_files="" # Ensure variable exists

    local all_files
    all_files=$(get_file_list "$search_dir") || return 1 # Exit if find failed

    if [[ -z "$all_files" && -z "$recent_files" ]]; then
        notify "No files found in $search_dir"
        return 0 # Not an error, just no files
    fi

    # Combine recent files with all files (prioritize recent)
    local file_list
    file_list=$(echo -e "${recent_files}\n${all_files}" | awk '!seen[$0]++') # Unique list, recent first

    # Select file with rofi - removed problematic drun option
    # Added -no-custom to prevent accidental text submission if rofi theme has input bar text
    local selected_file
    selected_file=$(echo -e "$file_list" | rofi -dmenu -theme "$THEME_PATH" -i -p "Find File:" -matching normal -tokenize -no-custom)

    # If a file was selected, open it
    if [ -n "$selected_file" ]; then
        # Check if the selected path is actually a file (user might type something invalid)
        if [ -f "$selected_file" ]; then
            # Add to recent files
            add_to_recent_files "$selected_file"

            # Copy the path to clipboard
            echo -n "$selected_file" | wl-copy

            # Prepare editor command safely using the quoted EDITOR template
            local open_cmd
            # Simple string replacement is fine here because EDITOR has quoted placeholders
            open_cmd="${EDITOR//\{\}/$selected_file}"

            # Open the file using eval
            # Use setsid or similar if you want the script to exit without waiting for kitty
            ( setsid sh -c "eval '$open_cmd'" >/dev/null 2>&1 & )

            # Notify the user
            notify "Opening: $(basename "$selected_file")"
        else
            notify "Error: '$selected_file' is not a valid file."
        fi
    # else: User cancelled rofi (Escape key or no selection) - do nothing silently
    fi
}

# Clean cache files
clean_cache() {
    rm -rf "$CACHE_DIR"/*
    notify "Cache cleaned"
}

# Display help
show_help() {
    echo "Usage: $0 [OPTIONS] [DIRECTORY]"
    echo
    echo "Fuzzy finds files using rofi, starting from DIRECTORY (default: $DEFAULT_SEARCH_DIR)."
    echo
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  -c, --clean     Clean the cache directory ($CACHE_DIR)"
    echo "  -r, --recent    Show only recent files via rofi"
    echo
    echo "Exclusions:"
    echo "  Dirs: ${EXCLUDE_DIRS[*]}"
    echo "  Files: ${EXCLUDE_FILES[*]}"
}

# ------------------------------------------
# Main Execution
# ------------------------------------------

# Check dependencies first
check_dependencies

# Parse arguments
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "-c" || "$1" == "--clean" ]]; then
    clean_cache
    exit 0
elif [[ "$1" == "-r" || "$1" == "--recent" ]]; then
    recent_files=$(get_recent_files)
    if [ -n "$recent_files" ]; then
        selected_file=$(echo "$recent_files" | rofi -dmenu -theme "$THEME_PATH" -i -p "Recent Files:" -matching normal -tokenize -no-custom)
        if [ -n "$selected_file" ] && [ -f "$selected_file" ]; then
            add_to_recent_files "$selected_file" # Keep it at the top
            echo -n "$selected_file" | wl-copy
            open_cmd="${EDITOR//\{\}/$selected_file}"
            ( setsid sh -c "eval '$open_cmd'" >/dev/null 2>&1 & )
            notify "Opening: $(basename "$selected_file")"
        elif [ -n "$selected_file" ]; then
             notify "Error: '$selected_file' is not a valid file."
        fi
    else
        notify "No recent files found"
    fi
    exit 0
elif [[ "$1" == -* ]]; then
    # Handle unknown options
    echo "Error: Unknown option $1" >&2
    show_help
    exit 1
else
    # Default action: find files in specified directory or default
    find_files "$1" # find_files handles the default if $1 is empty
    exit $? # Exit with the status code of find_files
fi

exit 0 # Should only be reached if help/clean/recent succeeded without error