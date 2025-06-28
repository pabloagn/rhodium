#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script interactively removes orphaned configuration directories
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rc-helpers.sh"

function clean_orphaned_configs() {
    print_partial "This will remove orphaned configuration directories"
    echo "Press Ctrl+C to cancel"
    echo

    local installed_pkgs=$(get_installed_packages)
    local removed_count=0

    while IFS= read -r -d '' dir; do
        local dirname=$(basename "$dir")

        # Skip system directories
        if is_system_directory "$dirname"; then
            continue
        fi

        # Check if package is installed
        if ! grep -q "^${dirname}$" "$installed_pkgs"; then
            local size=$(du -sh "$dir" 2>/dev/null | cut -f1)

            if yes_or_no "Remove $dirname [$size]?"; then
                rm -rf "$dir"
                print_success "  Removed"
                ((removed_count++))
            else
                echo "  Skipped"
            fi
        fi
    done < <(find "${HOME_DIR}/.config" -maxdepth 1 -type d ! -path "${HOME_DIR}/.config" -print0)

    rm -f "$installed_pkgs"

    echo
    print_success "Removed $removed_count orphaned directories"
}

function main() {
    clean_orphaned_configs
}

main "$@"
