#!/usr/bin/env bash
# Enhanced test script for supernova.sh with detailed error reporting

# --- Configuration ---
# Absolute paths based on your information
SCRIPT_PATH="/home/pabloagn/.dotfiles/user/desktop/rofi/scripts/supernova.sh"
THEME_PATH="/home/pabloagn/.dotfiles/user/desktop/rofi/themes/supernova.rasi"
LOG_FILE="/tmp/supernova_test_$(date +%s).log"
MODI_NAME="finder" # The name used in the rofi -modi command

# --- Setup Error Logging ---
# Create the log file and make it accessible
touch "$LOG_FILE"
chmod 666 "$LOG_FILE"
echo "=== Supernova Test Log ($(date)) ===" > "$LOG_FILE"
echo "Script: $SCRIPT_PATH" >> "$LOG_FILE"
echo "Theme: $THEME_PATH" >> "$LOG_FILE"
echo "===================================" >> "$LOG_FILE"

# --- Helper Functions ---
log() {
    echo "$@" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "\e[31mERROR: $@\e[0m" | tee -a "$LOG_FILE"
}

log_warning() {
    echo -e "\e[33mWARNING: $@\e[0m" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "\e[32m$@\e[0m" | tee -a "$LOG_FILE"
}

usage() {
    echo "Usage: $0 [OPTION | DIRECTORY]"
    echo
    echo "Launch the Supernova Rofi script with different options."
    echo
    echo "Options:"
    echo "  (no argument)   Launch default search (usually in \$HOME)."
    echo "  --recent        Launch showing recent files."
    echo "  --debug         Run with maximum verbosity and debug output."
    echo "  DIRECTORY       Launch searching within the specified DIRECTORY."
    echo "  -h, --help      Show this help message."
    echo
    echo "Examples:"
    echo "  $0              # Default search"
    echo "  $0 --recent     # Show recent files"
    echo "  $0 ~/Projects   # Search within ~/Projects directory"
    echo "  $0 --debug      # Run with debug output"
    echo
    echo "Log file: $LOG_FILE"
}

# --- Check Dependencies ---
check_dependencies() {
    local missing=()
    
    # Check for required commands
    for cmd in rofi md5sum realpath stat; do
        if ! command -v "$cmd" > /dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done
    
    # Check optional but recommended commands
    for cmd in bat fd notify-send wl-copy; do
        if ! command -v "$cmd" > /dev/null 2>&1; then
            log_warning "Optional dependency '$cmd' not found. Some features may be limited."
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing required dependencies: ${missing[*]}"
        return 1
    fi
    
    return 0
}

# --- Check if files exist ---
check_files() {
    if [[ ! -f "$SCRIPT_PATH" ]]; then
        log_error "Script not found: $SCRIPT_PATH"
        return 1
    fi
    
    if [[ ! -x "$SCRIPT_PATH" ]]; then
        log_error "Script not executable: $SCRIPT_PATH"
        log "Run 'chmod +x $SCRIPT_PATH' to make it executable"
        return 1
    fi
    
    if [[ ! -f "$THEME_PATH" ]]; then
        log_error "Theme not found: $THEME_PATH"
        return 1
    fi
    
    # Read the first few lines of the theme file to check if it's valid Rofi theme
    if ! head -n 5 "$THEME_PATH" | grep -q "configuration\|window\|mainbox"; then
        log_warning "Theme file may not be a valid Rofi theme. Check contents."
    fi
    
    return 0
}

# --- Validate script configuration ---
validate_script() {
    # Check if script has the necessary preview functionality
    if ! grep -q "generate_preview" "$SCRIPT_PATH"; then
        log_warning "Script may not have preview function implemented"
    fi
    
    # Check if theme is properly referenced in the script
    if ! grep -q "$THEME_PATH" "$SCRIPT_PATH"; then
        log_warning "Theme path in script may not match provided theme"
    
    fi
    return 0
}

# --- Run Rofi with debugging ---
run_rofi() {
    local mode="$1"
    local arg="$2"
    local cmd=""
    
    log "Launching Rofi with mode: $mode"
    
    if [[ "$mode" == "default" ]]; then
        cmd="rofi -show \"$MODI_NAME\" -modi \"${MODI_NAME}:${SCRIPT_PATH}\" -theme \"$THEME_PATH\""
    elif [[ "$mode" == "recent" ]]; then
        cmd="rofi -show \"$MODI_NAME\" -modi \"${MODI_NAME}:${SCRIPT_PATH} --recent\" -theme \"$THEME_PATH\""
    elif [[ "$mode" == "directory" ]]; then
        local search_dir=$(realpath "$arg")
        log "Directory search: $search_dir"
        cmd="rofi -show \"$MODI_NAME\" -modi \"${MODI_NAME}:${SCRIPT_PATH} ${search_dir}\" -theme \"$THEME_PATH\""
    elif [[ "$mode" == "debug" ]]; then
        # Add -debug flag to rofi for maximum verbosity
        cmd="rofi -show \"$MODI_NAME\" -modi \"${MODI_NAME}:${SCRIPT_PATH}\" -theme \"$THEME_PATH\" -debug"
    else
        log_error "Unknown mode: $mode"
        return 1
    fi
    
    log "Executing: $cmd"
    
    # Create a temporary file to capture stderr
    local stderr_file=$(mktemp)
    
    # Execute the command and redirect stderr to our file
    eval "$cmd" 2> "$stderr_file"
    local exit_code=$?
    
    # Check if there were any errors
    if [[ -s "$stderr_file" ]]; then
        log_error "Rofi reported errors:"
        cat "$stderr_file" | tee -a "$LOG_FILE"
    fi
    
    # Clean up temp file
    rm -f "$stderr_file"
    
    if [[ $exit_code -ne 0 ]]; then
        log_error "Rofi exited with code: $exit_code"
        return $exit_code
    else
        log_success "Rofi completed successfully"
        return 0
    fi
}

# --- Main Execution ---
main() {
    # Parse arguments
    local ARG="$1"
    
    if [[ "$ARG" == "-h" || "$ARG" == "--help" ]]; then
        usage
        exit 0
    fi
    
    # Log system info
    log "System: $(uname -a)"
    log "Rofi version: $(rofi -version 2>&1)"
    
    # Check dependencies and files
    check_dependencies || exit 1
    check_files || exit 1
    validate_script
    
    if [[ -z "$ARG" ]]; then
        # Default search
        run_rofi "default"
    elif [[ "$ARG" == "--recent" ]]; then
        # Recent files mode
        run_rofi "recent"
    elif [[ "$ARG" == "--debug" ]]; then
        # Debug mode
        run_rofi "debug"
    elif [[ -d "$ARG" ]]; then
        # Specific directory mode
        run_rofi "directory" "$ARG"
    else
        # Invalid argument
        log_error "Invalid argument or directory not found: '$ARG'"
        usage
        exit 1
    fi
    
    local result=$?
    log "Test completed with exit code: $result"
    log "Log file: $LOG_FILE"
    
    exit $result
}

# Run the main function
main "$@"