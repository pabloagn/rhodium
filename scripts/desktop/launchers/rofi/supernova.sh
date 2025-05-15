#!/usr/bin/env bash

# --------------------------------------------------------
# supernova.sh - Enhanced fuzzy file finder for NixOS (Next Generation - Uses Rofi Script Mode)
#
# Usage:
#   1. Configure Rofi modi:
#      modi: "finder:~/.config/rofi/scripts/fuzzy_finder_ng.sh"; // Adjust path
#   2. Run rofi:
#      rofi -show finder -theme <your_theme_with_preview_support>
#   3. Command-line options (run script directly):
#      ~/.config/rofi/scripts/fuzzy_finder_ng.sh --clean
#      ~/.config/rofi/scripts/fuzzy_finder_ng.sh --help
# --------------------------------------------------------

# --- Configuration ---
# Ensure THEME_PATH points to a theme *designed for previews*
THEME_PATH="${HOME}/.dotfiles/user/desktop/rofi/themes/supernova.rasi" # Might need a different theme
# Quote the placeholders within the EDITOR string for robustness
EDITOR="kitty --directory \"\$(dirname '{}')\" nvim '{}'"
DEFAULT_SEARCH_DIR="${HOME}"
MAX_DEPTH=10
# Use an array for exclusions
EXCLUDE_DIRS=(".git" "node_modules" ".cache" ".npm" ".pnpm" ".Trash" ".local/share/Trash" "__pycache__")
EXCLUDE_FILES=("*.o" "*.so" "*.pyc" "*.pyo" "*.swp" "*.swo") # Added swap files
RECENT_FILES_MAX=50 # Increased recent files
RECENT_FILES_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/fuzzy_finder_ng_history"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/fuzzy_finder_ng"
CACHE_TIMEOUT=3600  # Cache timeout in seconds (1 hour)
PREVIEW_WIDTH_PERCENT=60 # Percentage of terminal width for preview

# --- Setup ---
mkdir -p "$CACHE_DIR"
mkdir -p "$(dirname "$RECENT_FILES_PATH")"
touch "$RECENT_FILES_PATH"

# --- Helper Functions ---

# Notification function
notify() {
    notify-send "Fuzzy Finder NG" "$1" -a "Fuzzy Finder NG" -t 3000 # Short timeout
}

# Check if required tools are installed
check_dependencies() {
    local missing_deps=()
    # Added tput for preview width, fd-find as optional alternative
    for cmd in rofi wl-copy notify-send bat tput; do
        if ! command -v "$cmd" > /dev/null 2>&1; then
            # Allow bat to be optional, but highly recommended for previews
            if [[ "$cmd" == "bat" ]]; then
                echo "Warning: 'bat' not found. Previews will use 'head' (no syntax highlighting)." >&2
            else
                 missing_deps+=("$cmd")
            fi
        fi
    done

    # Check for find OR fd (preferred if available)
    if ! command -v fd > /dev/null 2>&1 && ! command -v find > /dev/null 2>&1; then
         missing_deps+=("find or fd")
    fi


    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo "Error: Missing dependencies: ${missing_deps[*]}" >&2
        # Only notify if running interactively (not called by rofi itself initially)
        if [[ -t 1 ]]; then
             notify "Error: Missing dependencies: ${missing_deps[*]}"
        fi
        exit 1
    fi
}

# File preview function (uses bat or head)
generate_preview() {
    local file="$1"
    local max_height=30 # Max lines for text preview
    local term_width preview_width

    # Try getting terminal width, default to 80 if tput fails
    term_width=$(tput cols 2>/dev/null || echo 80)
    # Calculate width based on theme layout (listview ~45%, preview ~55%)
    preview_width=$(( term_width * 50 / 100 )) # Adjust percentage if needed
    [[ "$preview_width" -lt 40 ]] && preview_width=40

    # Clear previous background image and ensure text preview is targeted initially
    echo -e "\0background-image\x1fnone" # Clear background image first!

    if [[ ! -r "$file" ]]; then
        echo "Preview Error: Cannot read file or file does not exist."
        echo "$file"
        return
    fi

    local mime_type
    mime_type=$(file -bL --mime-type "$file")

    # Handle Images
    if [[ "$mime_type" == image/* ]]; then
        # Set background-image for previewbox and clear text content
        # Note: Ensure the path is properly escaped if needed, realpath helps.
        local escaped_path
        escaped_path=$(printf "%q" "$(realpath "$file")") # Quote for safety
        echo -e "\0background-image\x1furl(\"${escaped_path}\", Pango)" # Pango might be needed depending on rofi version for correct path handling
        echo "" # Output empty string to clear text preview area
        return
    fi

    # Handle Directories
    if [[ "$mime_type" == "inode/directory" ]]; then
        echo "Directory Preview:"
        # Use exa or lsd for better icons/colors if available, fallback to ls
        if command -v exa >/dev/null 2>&1; then
             exa --color=always --icons -1 --group-directories-first "$file" | head -n $max_height
        elif command -v lsd >/dev/null 2>&1; then
             lsd --color=always --icon=auto -1 "$file" | head -n $max_height
        else
             ls -p --color=always "$file" | head -n $max_height
        fi
        return
    fi

    # Handle Binary Files (other than images)
    if ! grep -qI "$file"; then
        echo "Binary File: $mime_type"
        echo "Size: $(du -sh "$file" | cut -f1)"
        echo -e "\n--- Hexdump (first 256 bytes) ---"
        hexdump -C "$file" | head -n 16
        return
    fi

    # Handle Text/Code Files using bat
    if command -v bat >/dev/null 2>&1; then
        # Use --style=plain to avoid bat adding its own box/grid
        # Rely on Pango markup from --color=always for syntax highlighting
         bat --color=always --style=plain --line-range=:$max_height --terminal-width=$preview_width "$file" 2>/dev/null || {
            echo "Bat preview failed. Falling back to head."
            head -n $max_height "$file"
        }
    else
        head -n $max_height "$file"
    fi
}

# Add file to recent files list
add_to_recent_files() {
    local file="$1"
    # Ensure file exists before adding
    if [[ ! -e "$file" ]]; then # Use -e to allow adding directories too if ever needed
        return
    fi
    # Ensure path is absolute
    file=$(realpath "$file")

    local temp_file
    temp_file=$(mktemp)
    echo "$file" > "$temp_file"
    if [[ -f "$RECENT_FILES_PATH" ]]; then
        # Filter out the file if it already exists, before adding it to the top
         grep -Fxv "$file" "$RECENT_FILES_PATH" >> "$temp_file" || true
    fi
    # awk unique (shouldn't be needed but safe), limit size, then replace original
    # awk '!seen[$0]++' "$temp_file" | head -n "$RECENT_FILES_MAX" > "$RECENT_FILES_PATH"
    # Simpler: just limit lines after prepend/filter
    head -n "$RECENT_FILES_MAX" "$temp_file" > "$RECENT_FILES_PATH"
    rm "$temp_file"
}


# Get cached file list or generate new one using 'fd' or 'find'
get_file_list() {
    local search_dir="$1"
    # Use a more robust cache filename
    local cache_key
    cache_key=$(printf "%s" "$search_dir" | md5sum | cut -d' ' -f1)
    local cache_file="$CACHE_DIR/$cache_key"

    # Check cache freshness
    if [[ -f "$cache_file" ]]; then
        local cache_age=$(( $(date +%s) - $(stat -c %Y "$cache_file") ))
        if [[ $cache_age -lt $CACHE_TIMEOUT ]]; then
            cat "$cache_file"
            return 0 # Success
        fi
    fi

    # --- Generate file list ---
    echo "Generating file list for $search_dir..." >&2 # Info message

    local cmd_output
    if command -v fd > /dev/null 2>&1; then
        # Use fd (more modern, often faster, simpler syntax)
        local fd_args=(-L --type f --max-depth "$MAX_DEPTH" --absolute-path) # -L follows symlinks
        # Add hidden flag if needed: --hidden
        # Add exclusions
        for dir in "${EXCLUDE_DIRS[@]}"; do fd_args+=(--exclude "$dir"); done
        for file in "${EXCLUDE_FILES[@]}"; do fd_args+=(--exclude "$file"); done
        # Run fd
        cmd_output=$(fd "${fd_args[@]}" . "$search_dir" 2>/dev/null)
    else
        # Fallback to find
        local find_args=("$search_dir" -maxdepth "$MAX_DEPTH")
        # Exclude directories using -prune
        local prune_paths=()
        for dir in "${EXCLUDE_DIRS[@]}"; do
             prune_paths+=(-o -path "*/$dir" -prune)
        done
        find_args+=(\( "${prune_paths[@]:1}" \)) # Add prune conditions correctly grouped

        # Exclude files by name
        local name_excludes=()
        for file in "${EXCLUDE_FILES[@]}"; do
            name_excludes+=(-o -name "$file")
        done
         # Apply file type and name exclusions, then print
        find_args+=(-o -type f \( -not \( "${name_excludes[@]:1}" \) \) -print)
        # Run find
        cmd_output=$(find "${find_args[@]}" 2>/dev/null)
    fi

    # Sort and cache the results
    if echo "$cmd_output" | sort > "$cache_file"; then
        cat "$cache_file"
    else
        rm -f "$cache_file"
        echo "Error generating file list for $search_dir" >&2
        notify "Error generating file list for $search_dir"
        return 1 # Failure
    fi
}

# Clean cache files
clean_cache() {
    echo "Cleaning cache directory: $CACHE_DIR"
    rm -rf "$CACHE_DIR"/*
    notify "Cache cleaned"
}

# Display help
show_help() {
    echo "Usage: $0 [--clean|--help]"
    echo "       rofi -show finder -modi \"finder:$0 [search_dir|--recent]\""
    echo
    echo "Rofi Script Mode fuzzy finder with previews."
    echo
    echo "Options (when run directly):"
    echo "  --help      Show this help message"
    echo "  --clean     Clean the cache directory ($CACHE_DIR)"
    echo
    echo "Rofi Modi Arguments:"
    echo "  (none)      Search in default directory ($DEFAULT_SEARCH_DIR)"
    echo "  search_dir  Search in the specified directory"
    echo "  --recent    Show only recent files"
    echo
    echo "Configuration:"
    echo "  Editor: $EDITOR"
    echo "  Theme: $THEME_PATH (must support previews!)"
    echo "  Exclusions: Dirs(${EXCLUDE_DIRS[*]}), Files(${EXCLUDE_FILES[*]})"
}


# ------------------------------------------
# Main Execution Logic
# ------------------------------------------

# --- Direct Command Line Invocation Handling ---
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "--clean" ]]; then
    check_dependencies # Need notify-send
    clean_cache
    exit 0
elif [[ "$1" == -* && -t 1 ]]; then # Check if it's an option and running interactively
     echo "Error: Unknown direct option: $1" >&2
     show_help
     exit 1
fi

# --- Rofi Script Mode ---

# Check dependencies required for Rofi mode
check_dependencies

# Determine mode (recent or search) and search directory
MODE="search"
SEARCH_DIR="$DEFAULT_SEARCH_DIR"
ROFI_INFO="$@" # Capture all arguments passed by Rofi modi

if [[ -n "$ROFI_INFO" ]]; then
    if [[ "$ROFI_INFO" == "--recent" ]]; then
        MODE="recent"
    else
        # Assume the argument is the search directory
        if [[ -d "$ROFI_INFO" ]]; then
            SEARCH_DIR=$(realpath "$ROFI_INFO") # Resolve to absolute path
        else
            # If passed info isn't --recent or a dir, maybe it's a selected file?
            # Rofi passes selected entry as $1 (captured in ROFI_INFO if it's the only arg)
             # Let the logic below handle this.
             : # No-op, fall through
        fi
    fi
fi


# If no argument is passed by Rofi ($# -eq 0), this is the initial call.
# Rofi sets environment variables for subsequent calls (selection/highlight).
if [[ -z "$ROFI_INFO" && -z "$ROFI_RETV" ]]; then
    # --- Initial Call: Populate the list ---
    echo -e "\0prompt\x1f🔍 Find File" # Set Rofi prompt
    echo -e "\0keep-selection\x1ftrue" # Keep selection info after filtering
    echo -e "\0use-preview\x1ftrue"    # Enable the preview mechanism

    # Get file lists
    recent_files=$(get_recent_files) || recent_files=""
    all_files=$(get_file_list "$SEARCH_DIR") || all_files="" # Use default dir

    if [[ -z "$recent_files" && -z "$all_files" ]]; then
        echo -e "\0message\x1fNo files found in $SEARCH_DIR"
        exit 0
    fi

    # Combine recent files with all files (prioritize recent, ensure uniqueness)
    # Use awk for robust uniqueness handling
    echo -e "${recent_files}\n${all_files}" | awk '!seen[$0]++'

    exit 0

elif [[ "$MODE" == "recent" && -z "$ROFI_RETV" ]]; then
     # --- Initial Call (--recent mode): Populate the list ---
     echo -e "\0prompt\x1f📅 Recent Files" # Set Rofi prompt
     echo -e "\0keep-selection\x1ftrue"
     echo -e "\0use-preview\x1ftrue"

     recent_files=$(get_recent_files)
     if [[ -z "$recent_files" ]]; then
        echo -e "\0message\x1fNo recent files found"
        exit 0
     fi
     echo "$recent_files"
     exit 0

elif [[ "$MODE" == "search" && -d "$SEARCH_DIR" && -z "$ROFI_RETV" && "$SEARCH_DIR" != "$DEFAULT_SEARCH_DIR" ]]; then
    # --- Initial Call (specific search dir): Populate the list ---
    echo -e "\0prompt\x1f🔍 Find File in $(basename "$SEARCH_DIR")" # Set Rofi prompt
    echo -e "\0keep-selection\x1ftrue"
    echo -e "\0use-preview\x1ftrue"

    recent_files=$(get_recent_files) || recent_files=""
    all_files=$(get_file_list "$SEARCH_DIR") || all_files=""

    if [[ -z "$recent_files" && -z "$all_files" ]]; then
        echo -e "\0message\x1fNo files found in $SEARCH_DIR"
        exit 0
    fi

    echo -e "${recent_files}\n${all_files}" | awk '!seen[$0]++'
    exit 0
fi

# --- Subsequent Calls: Handle Selection/Preview ---
# Rofi sets $ROFI_RETV and passes the selected entry text as $1 (captured in ROFI_INFO)

SELECTED_FILE="$ROFI_INFO" # The text of the selected line

if [[ -n "$SELECTED_FILE" ]]; then
    # Make sure it's likely a valid path before proceeding
    if [[ ! -e "$SELECTED_FILE" ]]; then
         echo -e "\0message\x1fInvalid selection: $SELECTED_FILE"
         exit 0 # Exit gracefully for invalid selections/typing
    fi

    # Check ROFI_RETV to determine action
    # ROFI_RETV=1 means Enter key pressed (final selection)
    # Other values (or unset) usually mean highlighting (for preview)

    if [[ "$ROFI_RETV" -eq 1 ]]; then
        # --- Final Action: Open the selected file ---
        if [[ -f "$SELECTED_FILE" ]]; then
            # Add to recent files
            add_to_recent_files "$SELECTED_FILE"

            # Copy the path to clipboard
            echo -n "$SELECTED_FILE" | wl-copy

            # Prepare editor command safely
            open_cmd="${EDITOR//\{\}/$SELECTED_FILE}"

            # Open the file in the background, detached
            ( setsid sh -c "eval '$open_cmd'" >/dev/null 2>&1 & )

            # Notify the user (optional, rofi closes anyway)
            # notify "Opening: $(basename "$SELECTED_FILE")"

            exit 0 # Exit script after action
        elif [[ -d "$SELECTED_FILE" ]]; then
             # Optional: Handle selecting a directory (e.g., open in file manager or cd terminal)
             # Example: Open directory with kitty in that dir
             add_to_recent_files "$SELECTED_FILE" # Add dir to recent
             ( setsid kitty --directory "$SELECTED_FILE" >/dev/null 2>&1 & )
             # notify "Opening directory: $(basename "$SELECTED_FILE")"
             exit 0
        else
             notify "Error: Selected path is not a regular file or directory."
             exit 1 # Indicate error
        fi

    else
        # --- Preview Action: Generate and output preview ---
        # Rofi is highlighting an item, generate preview for $SELECTED_FILE
        generate_preview "$SELECTED_FILE"
        exit 0 # Exit after providing preview content
    fi
fi

# Fallback exit if none of the conditions were met (should not happen ideally)
exit 1