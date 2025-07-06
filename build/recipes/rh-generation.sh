#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script shows system generation details
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-generation"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function main() {
    echo "--- SYSTEM GENERATIONS ---"
    sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -10
}

main "$@"
