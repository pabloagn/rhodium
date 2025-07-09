#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-z"
APP_TITLE="Rhodium's Z-Utils"
PROMPT="ζ: "

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# Terminal configuration
TERMINAL="${TERMINAL:-kitty}"

# Define apps that need --hold flag
HOLD_APPS=(
    "fastfetch"
    "ascii"
    "cal"
    "bc"
    "cmatrix"
)

# Define apps that don't need terminal (GUI apps or background pickers)
NO_TERMINAL_APPS=(
    "nix-web"
    "utils-kill"
    "utils-opacity"
    "utils-screenshot-annotate"
)

options=()

# Helper function to check if app needs --hold
needs_hold() {
    local app="$1"
    for hold_app in "${HOLD_APPS[@]}"; do
        [[ "$app" == "$hold_app" ]] && return 0
    done
    return 1
}

# Helper function to check if app needs terminal
needs_terminal() {
    local app="$1"
    for no_term_app in "${NO_TERMINAL_APPS[@]}"; do
        [[ "$app" == "$no_term_app" ]] && return 1
    done
    return 0
}

# Helper function to run apps with appropriate terminal settings
run_app() {
    local app="$1"
    local cmd="$2"
    
    if ! needs_terminal "$app"; then
        # Run without terminal
        eval "$cmd &"
        disown
        return
    fi
    
    if needs_hold "$app"; then
        # Run with --hold flag
        $TERMINAL -e --hold bash -c "$cmd" &
    else
        # Run without --hold
        $TERMINAL -e bash -c "$cmd" &
    fi
    disown
}

# Helper function to check if command exists and notify if missing
check_command() {
    local cmd="$1"
    local package="$2"
    
    if ! command -v "$cmd" &>/dev/null; then
        notify "$APP_TITLE" "Please Install Missing Packages\n◌ $package"
        return 1
    fi
    return 0
}

# Helper function to check if file exists
check_file() {
    local file="$1"
    local description="$2"
    
    if [[ ! -f "$file" ]]; then
        notify "$APP_TITLE" "File Not Found\n◌ $description\n◌ Path: $file"
        return 1
    fi
    return 0
}

# Utility functions
launch_fastfetch() {
    check_command "fastfetch" "fastfetch" || return 1
    run_app "fastfetch" "{$XDG_BIN_HOME}/launchers/launchers-fastfetch.sh"
}

launch_ascii() {
    check_command "ascii" "ascii" || return 1
    run_app "ascii" "ascii"
}

launch_htop() {
    check_command "htop" "htop" || return 1
    run_app "htop" "htop"
}

launch_btop() {
    check_command "btop" "btop" || return 1
    run_app "btop" "btop"
}

launch_calcure() {
    check_command "calcure" "calcure" || return 1
    run_app "calcure" "calcure"
}

launch_cal() {
    check_command "cal" "util-linux" || return 1
    run_app "cal" "cal"
}

launch_nix_top() {
    check_command "nix-top" "nix-top" || return 1
    run_app "nix-top" "nix-top"
}

launch_nix_web() {
    if ! check_command "nix-web" "nix-web"; then
        return 1
    fi
    if ! check_command "firefox" "firefox"; then
        return 1
    fi
    
    # Start nix-web in background
    nix-web &
    disown
    
    # Wait a moment for service to start, then open browser
    sleep 2
    firefox -p Personal http://localhost:8649/ &
    disown
    
    notify "$APP_TITLE" "Nix Web Started\n◌ Service: nix-web\n◌ Browser: firefox (personal profile)"
}

launch_nix_melt() {
    check_command "nix-melt" "nix-melt" || return 1
    
    if [[ -z "${RHODIUM:-}" ]]; then
        notify "$APP_TITLE" "Environment Variable Missing\n◌ RHODIUM not set"
        return 1
    fi
    
    if [[ ! -d "$RHODIUM" ]]; then
        notify "$APP_TITLE" "Directory Not Found\n◌ RHODIUM: $RHODIUM"
        return 1
    fi
    
    run_app "nix-melt" "cd '$RHODIUM' && nix-melt"
}

launch_btm() {
    check_command "btm" "bottom" || return 1
    run_app "btm" "btm"
}

launch_nmtui() {
    check_command "nmtui" "networkmanager" || return 1
    run_app "nmtui" "nmtui"
}

launch_bc() {
    check_command "bc" "bc" || return 1
    run_app "bc" "bc -l"
}

launch_mprocs() {
    check_command "mprocs" "mprocs" || return 1
    run_app "mprocs" "mprocs"
}

launch_presenterm() {
    check_command "presenterm" "presenterm" || return 1
    check_command "fuzzel" "fuzzel" || return 1
    
    # Find markdown files in current directory and subdirectories
    local md_files
    md_files=$(find . -name "*.md" -type f 2>/dev/null | head -20)
    
    if [[ -z "$md_files" ]]; then
        notify "$APP_TITLE" "No Markdown Files Found\n◌ Search path: $(pwd)"
        return 1
    fi
    
    local selected_file
    selected_file=$(echo "$md_files" | fuzzel --dmenu -p "Select markdown file: " -l 10 -w 90)
    
    if [[ -z "$selected_file" ]]; then
        return 0
    fi
    
    if [[ -f "$selected_file" ]]; then
        run_app "presenterm" "presenterm '$selected_file'"
    else
        notify "$APP_TITLE" "File Not Found\n◌ Selected: $selected_file"
    fi
}

launch_tv() {
    check_command "tv" "television" || return 1
    run_app "tv" "tv"
}

launch_fzf() {
    check_command "fzf" "fzf" || return 1
    run_app "fzf" "fzf"
}

launch_skim() {
    check_command "sk" "skim" || return 1
    run_app "skim" "sk"
}

launch_cmatrix() {
    check_command "cmatrix" "cmatrix" || return 1
    run_app "cmatrix" "cmatrix"
}

# Custom utils functions - these run in background as pickers
launch_utils_kill() {
    local util_path="${XDG_HOME_BIN:-$HOME/.local/bin}/utils/utils-kill.sh"
    check_file "$util_path" "utils-kill.sh" || return 1
    run_app "utils-kill" "$util_path"
}

launch_utils_opacity() {
    local util_path="${XDG_HOME_BIN:-$HOME/.local/bin}/utils/utils-opacity.sh"
    check_file "$util_path" "utils-opacity.sh" || return 1
    run_app "utils-opacity" "$util_path"
}

launch_utils_screenshot_annotate() {
    local util_path="${XDG_HOME_BIN:-$HOME/.local/bin}/utils/utils-screenshot-annotate.sh"
    check_file "$util_path" "utils-screenshot-annotate.sh" || return 1
    run_app "utils-screenshot-annotate" "$util_path"
}

noop() {
    :
}

generate_menu_options() {
    options=()
    
    options+=("FastFetch (System Info):launch_fastfetch")
    options+=("Htop (Process Monitor):launch_htop")
    options+=("Btop (Process Monitor):launch_btop")
    options+=("Bottom (Process Monitor):launch_btm")
    options+=("Nix Top (Nix Processes):launch_nix_top")
    options+=("Calendar (Terminal):launch_cal")
    options+=("Calculator (Interactive):launch_bc")
    options+=("ASCII Table (Reference):launch_ascii")
    options+=("Network Manager (TUI):launch_nmtui")
    options+=("Multi Process (Manager):launch_mprocs")
    options+=("FZF (Fuzzy Finder):launch_fzf")
    options+=("Skim (Fuzzy Finder):launch_skim")
    options+=("Television (File Browser):launch_tv")
    options+=("Nix Web (Browser Interface):launch_nix_web")
    options+=("Nix Melt (Flake Explorer):launch_nix_melt")
    options+=("Calcure (Calendar App):launch_calcure")
    options+=("Presenterm (Markdown Slides):launch_presenterm")
    options+=("Process Killer (Rhodium Utils):launch_utils_kill")
    options+=("Opacity Control (Rhodium Utils):launch_utils_opacity")
    options+=("Screenshot Annotate (Rhodium Utils):launch_utils_screenshot_annotate")
    options+=("Matrix Effect (Fun):launch_cmatrix")
    options+=("Exit:noop")
}

main() {
    # Check for required dependencies
    if ! command -v "$TERMINAL" &>/dev/null; then
        notify "$APP_TITLE" "Terminal Not Found\n◌ TERMINAL=$TERMINAL\n◌ Please install or set TERMINAL environment variable"
        exit 1
    fi
    
    if ! command -v fuzzel &>/dev/null; then
        notify "$APP_TITLE" "Please Install Missing Packages\n◌ fuzzel"
        exit 1
    fi
    
    generate_menu_options
    
    decorate_fuzzel_menu options
    
    local line_count
    line_count=$(get_fuzzel_line_count)
    
    local selected
    selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count" -w 90)
    
    [[ -z "$selected" ]] && return
    
    if [[ "$selected" =~ ^---.*---$ ]]; then
        main
        return
    fi
    
    if [[ -n "${menu_commands[$selected]:-}" ]]; then
        eval "${menu_commands[$selected]}"
    else
        notify "$APP_TITLE" "No Command Associated\n◌ Selected: $selected"
    fi
}

main
