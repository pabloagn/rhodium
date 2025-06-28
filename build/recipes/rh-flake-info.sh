#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script shows flake metadata
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function main() {
    print_header "FLAKE INFORMATION"
    echo ""
    nix flake metadata "${FLAKE_PATH}"
}

main "$@"
