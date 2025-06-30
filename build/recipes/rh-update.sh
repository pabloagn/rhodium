#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script handles flake input updates
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function main() {
    if [ $# -eq 0 ]; then
        # Update all inputs
        print_pending "Updating all flake inputs..."
        nix flake update
        print_success "Flake inputs updated"
        echo ""
        print_info "Input changes:"
        git -C "${FLAKE_PATH}" diff flake.lock | grep -E "^\+" | grep -E "(lastModified|narHash)" | head -10 || true
    elif [ $# -eq 1 ]; then
        # Update specific input
        local input="$1"
        print_pending "Updating input: $input..."
        nix flake update "$input"
        print_success "Updated input: $input"
    else
        echo "Usage: $0 [input]"
        echo "Update all flake inputs or a specific input"
        exit 1
    fi
}

main "$@"
