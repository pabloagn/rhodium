#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script rolls back to previous generation
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function main() {
    print_partial "Rolling back to previous generation..."
    sudo nixos-rebuild switch --rollback
    print_success "Rollback complete"
}

main "$@"
