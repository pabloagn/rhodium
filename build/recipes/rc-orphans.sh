#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script finds orphaned configuration directories
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function find_orphaned_configs() {
    print_pending "Analyzing configuration orphans..."
    echo

    local installed_pkgs=$(get_installed_packages)
    local orphan_count=0

    while IFS= read -r -d '' dir; do
        local dirname=$(basename "$dir")

        # Skip system directories
        if is_system_directory "$dirname"; then
            continue
        fi

        # Check if package is installed
        if ! grep -q "^${dirname}$" "$installed_pkgs"; then
            local size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            print_partial "  $dirname [$size]"
            ((orphan_count++))
        fi
    done < <(find "${HOME_DIR}/.config" -maxdepth 1 -type d ! -path "${HOME_DIR}/.config" -print0)

    rm -f "$installed_pkgs"

    if [ $orphan_count -eq 0 ]; then
        print_success "  No orphaned configurations found"
    else
        echo
        echo "Total: $orphan_count potential orphans"
        echo "Use 'rhodium-clean-orphans.sh' to remove them"
    fi
}

function main() {
    find_orphaned_configs
}

main "$@"
