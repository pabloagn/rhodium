#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script checks for untracked files in the repository
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function check_untracked_files() {
    print_header "UNTRACKED FILES"

    local untracked_files=$(git -C "$FLAKE_PATH" ls-files --others --exclude-standard)

    if [ -z "$untracked_files" ]; then
        print_success "Repository is clean"
    else
        local count=$(echo "$untracked_files" | wc -l)
        print_partial "Found $count untracked files:"
        echo

        echo "$untracked_files" | while IFS= read -r file; do
            local size=$(du -h "${FLAKE_PATH}/$file" 2>/dev/null | cut -f1 || echo "?")
            print_info "  $file [$size]"
        done
    fi

    echo
    cyan "$BAR_HEAVY"
}

function main() {
    check_untracked_files
}

main "$@"
