#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-fuzzel-remote"
APP_TITLE="Rhodium's Remote Utils"
PROMPT="ρ: "

MENU_LEN=5
PADDING_ARGS_NIX_SEARCH="35 30 100"  # name, version, description

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Options ---
# Main menu options
# declare -A menu_options=(
#     ["⊹ Find Fonts"]="find_fonts"
#     ["⊹ Find Installed Packages"]="find_installed_packages"
#     ["⊹ Find Nix Packages"]="find_nix_packages"
#     ["⊹ List Derivations"]="list_derivations"
# )




