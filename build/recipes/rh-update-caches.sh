#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script provides a menu interface for updating application caches
#

# --- Imports ---
SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
CACHE_BUILDER="$COMMON_DIR/build-caches.sh"

if [[ ! -f "$CACHE_BUILDER" ]]; then
    echo "Error: Cache builder script not found at $CACHE_BUILDER"
    exit 1
fi

source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
# Interactive Menu Function
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

# Function To Convert Menu Choices To Cache-builder Arguments
build_args() {
    local choices=("$@")
    local args=()
    
    for choice in "${choices[@]}"; do
        case "$choice" in
            1) args+=("--fuzzel") ;;
            2) args+=("--bat") ;;
            3) args+=("--tldr") ;;
            4) args+=("--icons") ;;
            5) args+=("--nix") ;;
            6) args+=("--all") ;;
            7) args+=("--all-except-nix") ;;
        esac
    done
    
    echo "${args[@]}"
}

# Main Function
main() {
    local choices
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
            
            # Build arguments and execute cache builder
            local args
            args=$(build_args "${choices[@]}")
            
            if [[ -n "$args" ]]; then
                echo ""
                print_pending "Starting cache updates..."
                echo ""
                
                # Execute cache builder with arguments
                if "$CACHE_BUILDER" $args; then
                    echo ""
                    print_success "Cache updates completed!"
                else
                    echo ""
                    print_error "Some cache updates failed!"
                    exit 1
                fi
            fi
            
            break
        fi
    done
}

main "$@"
