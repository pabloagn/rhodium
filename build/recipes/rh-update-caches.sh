#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script updates application caches
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function main() {
    echo ""
    print_pending "Updating application caches..."
    "${MODULES_PATH}/cache/build-caches.sh"
    python3 "${MODULES_PATH}/cache/build-icons-cache.py"
}

main "$@"
