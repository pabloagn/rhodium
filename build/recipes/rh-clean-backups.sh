#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script cleans backup files
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-clean-backups"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function main() {
    notify "$APP_TITLE" "$RECIPE:\n◌This will remove all .backup and .bkp files. Press Ctrl+C in terminal to cancel."
    sleep 3

    count=$(find "${HOME}/.config" -type f \( -name "*.backup" -o -name "*.bkp" \) -delete -print | wc -l)
    notify "$APP_TITLE" "$RECIPE:\n◌Removed $count backup files"
}

main "$@"
