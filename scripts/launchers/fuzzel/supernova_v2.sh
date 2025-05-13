#!/usr/bin/env bash

# --------------------------------------------------------
# supernova.sh - Simple and reliable fuzzy file finder for NixOS
# --------------------------------------------------------

# --- Configuration ---
THEME_PATH="${HOME}/.dotfiles/user/desktop/rofi/themes/supernova.rasi"
EDITOR="kitty --directory \"\$(dirname '{}')\" nvim '{}'"
DEFAULT_SEARCH_DIR="${HOME}"
MAX_DEPTH=5
EXCLUDE_DIRS=(.git node_modules .cache __pycache__ .local/share/Trash)
EXCLUDE_FILES=(*.o *.so *.pyc *.pyo)
CACHE_DIR="${HOME}/.cache/supernova"
RECENT_FILE="${CACHE_DIR}/recent_files"

# --- Setup ---
mkdir -p "$CACHE_DIR"
touch "$RECENT_FILE"

# --- Helper Functions ---

# Notification function
notify() {
    notify-send "Supernova" "$1" -a "Supernova" -t 2000
}

# Generate a simple file preview
generate_preview() {
    local file="$1"
    
    if [[ ! -r "$file" ]]; then
        echo "Cannot read file: $file"
        return
    fi
    
    # Handle different file types
    if [[ -d "$file" ]]; then
        echo "Directory: $file"
        ls -la "$file" | head -n 20
        return
    fi
    
    local mime_type=$(file -b --mime-type "$file")
    
    if [[ "$mime_type" == "image/"* ]]; then
        echo "Image file: $(basename "$file")"
        echo "Path: $file"
        echo "Type: $mime_type"
        echo -e "\0background-image\x1ffile://$file"
    elif [[ "$mime_type" == "application/pdf" ]]; then
        echo "PDF file: $(basename "$file")"
        echo "Path: $file"
    elif [[ "$mime_type" == "text/"* || "$mime_type" == "application/json" ]]; then
        if command -v bat >/dev/null 2>&1; then
            bat --color=always --style=plain --line-range=:30 "$file" 2>/dev/null || head -n 30 "$file"
        else
            head -n 30 "$file"
        fi
    else
        echo "File: $(basename "$file")"
        echo "Type: $mime_type"
        echo "Size: $(du -h "$file" | cut -f1)"
        echo "Path: $file"
    fi
}

# Add to recent files
add_to_recent() {
    local file="$1"
    if [[ -f "$file" ]]; then
        echo "$file" > "$RECENT_FILE.tmp"
        if [[ -f "$RECENT_FILE" ]]; then
            grep -v "^$file$" "$RECENT_FILE" >> "$RECENT_FILE.tmp"
        fi
        head -n 50 "$RECENT_FILE.tmp" > "$RECENT_FILE"
        rm -f "$RECENT_FILE.tmp"
    fi
}

# Get recent files
get_recent_files() {
    if [[ -f "$RECENT_FILE" ]]; then
        cat "$RECENT_FILE"
    fi
}

# Find files using find command (safe fallback)
find_files() {
    local dir="$1"
    local exclude_args=()
    
    # Add directory exclusions
    for excl in "${EXCLUDE_DIRS[@]}"; do
        exclude_args+=(-not -path "*/$excl/*")
    done
    
    # Add file exclusions
    for excl in "${EXCLUDE_FILES[@]}"; do
        exclude_args+=(-not -name "$excl")
    done
    
    # Run find with all exclusions
    find "$dir" -type f -maxdepth "$MAX_DEPTH" "${exclude_args[@]}" 2>/dev/null | sort
}

# Clean the cache
clean_cache() {
    rm -rf "${CACHE_DIR:?}"/*
    mkdir -p "$CACHE_DIR"
    touch "$RECENT_FILE"
    notify "Cache cleaned"
}

# Show usage information
show_help() {
    echo "Usage: $0 [OPTION]"
    echo
    echo "Options:"
    echo "  --help    Show this help message"
    echo "  --clean   Clean the cache directory"
    echo "  --recent  Show only recent files"
    echo
    echo "This script is intended to be used with Rofi in script mode."
}

# --- Main Script Logic ---

# Handle command-line arguments
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "--clean" ]]; then
    clean_cache
    exit 0
fi

# Process Rofi script mode interface
ROFI_INFO="$1"
SEARCH_DIR="$DEFAULT_SEARCH_DIR"

# If ROFI_RETV is not set, this is the initial call from Rofi
if [[ -z "$ROFI_RETV" ]]; then
    # Process custom command if provided
    if [[ "$ROFI_INFO" == "--recent" ]]; then
        # Provide only recent files
        echo -e "\0prompt\x1fRecent Files"
        echo -e "\0use-preview\x1ftrue"
        
        files=$(get_recent_files)
        if [[ -z "$files" ]]; then
            echo "No recent files"
        else
            echo "$files"
        fi
        
        exit 0
    elif [[ -d "$ROFI_INFO" ]]; then
        # Use specified directory instead of default
        SEARCH_DIR="$ROFI_INFO"
    fi
    
    # Initial call - provide file list
    echo -e "\0prompt\x1fFind Files"
    echo -e "\0use-preview\x1ftrue"
    
    # Get and output files
    recent_files=$(get_recent_files)
    all_files=$(find_files "$SEARCH_DIR")
    
    # Combine and ensure uniqueness
    if [[ -n "$recent_files" && -n "$all_files" ]]; then
        echo -e "${recent_files}\n${all_files}" | awk '!seen[$0]++'
    elif [[ -n "$recent_files" ]]; then
        echo "$recent_files"
    elif [[ -n "$all_files" ]]; then
        echo "$all_files"
    else
        echo "No files found"
    fi
    
    exit 0
fi

# Handle selection or preview request
if [[ -n "$ROFI_INFO" ]]; then
    # Make sure it's a valid path
    if [[ ! -e "$ROFI_INFO" ]]; then
        echo "Invalid selection: $ROFI_INFO"
        exit 1
    fi
    
    # If ROFI_RETV=1, user made a final selection
    if [[ "$ROFI_RETV" -eq 1 ]]; then
        if [[ -f "$ROFI_INFO" ]]; then
            # Add to recent files
            add_to_recent "$ROFI_INFO"
            
            # Copy to clipboard
            echo -n "$ROFI_INFO" | wl-copy 2>/dev/null
            
            # Open the file
            eval "${EDITOR//\{\}/$ROFI_INFO}" &
            
            # Exit successfully
            exit 0
        else
            echo "Not a file: $ROFI_INFO"
            exit 1
        fi
    else
        # Generate preview for highlighted item
        generate_preview "$ROFI_INFO"
        exit 0
    fi
fi

exit 0