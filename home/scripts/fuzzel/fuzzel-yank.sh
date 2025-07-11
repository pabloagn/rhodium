#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "yank"

# --- Configuration ---
MENU_LEN=5
PADDING_ARGS="60 15 50" # service name, status, description
PADDING_ARGS_NIX_SEARCH="35 30 100"  # name, version, description

# --- Helper Functions ---

# --- Options ---
# Main menu options
# declare -A menu_options=(
#     ["⊹ Find Fonts"]="find_fonts"
#     ["⊹ Find Installed Packages"]="find_installed_packages"
#     ["⊹ Find Nix Packages"]="find_nix_packages"
#     ["⊹ List Derivations"]="list_derivations"
# )

