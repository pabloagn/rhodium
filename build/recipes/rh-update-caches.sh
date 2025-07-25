#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Provides a menu interface for updating application caches
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-update-caches"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Setup ---
CACHE_BUILDER="$COMMON_DIR/build-cache.sh"
if [[ ! -f "$CACHE_BUILDER" ]]; then
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} ERROR: Cache builder script not found!"
  exit 1
fi

# --- Functions ---
show_menu() {
  echo ""
  echo "  Select caches to update:"
  echo "  1) Apps Cache          6) Unicode Icons Cache"
  echo "  2) Launcher Cache      7) Nix Index Database"
  echo "  3) Wallpaper Cache     8) All Caches"
  echo "  4) Bat Syntax Cache    9) All Except Nix Index"
  echo "  5) TLDR Pages Cache    0) Exit"
  echo ""
}

build_args() {
  local choices=("$@")
  local args=()
  for choice in "${choices[@]}"; do
    case "$choice" in
    1) args+=("--apps") ;;
    2) args+=("--launcher") ;;
    3) args+=("--wallpapers") ;;
    4) args+=("--bat") ;;
    5) args+=("--tldr") ;;
    6) args+=("--icons") ;;
    7) args+=("--nix") ;;
    8) args+=("--all") ;;
    9) args+=("--all-except-nix") ;;
    esac
  done
  echo "${args[@]}"
}

main() {
  local choices choice
  while true; do
    show_menu
    read -rp "Enter choices (space-separated, e.g., '1 3 4'): " -a choices
    local valid=true
    for choice in "${choices[@]}"; do
      if ! [[ "$choice" =~ ^[0-9]$ ]]; then
        echo "Invalid choice: $choice"
        valid=false
        break
      fi
    done

    if [[ "$valid" == true ]]; then
      for choice in "${choices[@]}"; do if [[ "$choice" == "0" ]]; then exit 0; fi; done
      local args
      args=$(build_args "${choices[@]}")
      if [[ -n "$args" ]]; then
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Starting cache updates..."
        if "$CACHE_BUILDER" "$args"; then
          notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Cache updates completed!"
        else
          notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} ERROR: Some cache updates failed!"
          exit 1
        fi
      fi
      break
    fi
  done
}

main "$@"
