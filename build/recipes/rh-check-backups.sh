#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script checks for backup files in the config directory
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-check-backups"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function scan_backup_files() {
    notify "$APP_TITLE" "$RECIPE:\n◌Scanning for backup files..."
    echo

    local backup_count=0

    while IFS= read -r -d '' file; do
        local size
        size=$(du -h "$file" | cut -f1)
        local age=$((($(date +%s) - $(stat -c %Y "$file")) / 86400))

        echo "  ${file#"${HOME_DIR}"/.config/}"
        echo "     Size: $size | Age: $age days"
        ((backup_count++))
    done < <(find "${HOME_DIR}/.config" -type f \( -name "*.backup" -o -name "*.bkp" \) -print0 2>/dev/null)

    if [ $backup_count -eq 0 ]; then
        notify "$APP_TITLE" "$RECIPE:\n◌No backup files found"
    else
        echo
        echo "Total: $backup_count backup files"
    fi
}

function main() {
    scan_backup_files
}

main "$@"
