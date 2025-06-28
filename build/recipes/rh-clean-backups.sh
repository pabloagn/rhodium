#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script cleans backup files
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function main() {
    print_partial "This will remove all .backup and .bkp files"
    echo "Press Ctrl+C to cancel"
    echo ""
    sleep 2
    
    count=$(find "${HOME}/.config" -type f \( -name "*.backup" -o -name "*.bkp" \) -delete -print | wc -l)
    print_success "Removed $count backup files"
}

main "$@"
