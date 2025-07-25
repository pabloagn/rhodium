#!/usr/bin/env bash

set -euo pipefail

MENU_LEN=5
PADDING_ARGS_NIX_SEARCH="35 30 100"  # name, version, description

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "vaults"

# --- Options ---
# Main menu options
# declare -A menu_options=(
#     ["⊹ Find Fonts"]="find_fonts"
#     ["⊹ Find Installed Packages"]="find_installed_packages"
#     ["⊹ Find Nix Packages"]="find_nix_packages"
#     ["⊹ List Derivations"]="list_derivations"
# )




