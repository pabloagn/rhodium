#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script shows system generation details
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function main() {
    print_header "SYSTEM GENERATIONS"
    echo ""
    sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -10
}

main "$@"
