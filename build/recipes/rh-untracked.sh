#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Checks for untracked files in the repository
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-untracked"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
function check_untracked_files() {
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Checking for untracked files..."
  local untracked_files
  untracked_files=$(git -C "$FLAKE_PATH" ls-files --others --exclude-standard)

  if [ -z "$untracked_files" ]; then
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Repository is clean. No untracked files."
  else
    local count
    count=$(echo "$untracked_files" | wc -l)
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Found $count untracked files. See terminal for list."
    echo
    echo "$untracked_files" | while IFS= read -r file; do
      local size
      size=$(du -h "${FLAKE_PATH}/$file" 2>/dev/null | cut -f1 || echo "?")
      echo "  $file [$size]"
    done
    echo
  fi
}

function main() {
  check_untracked_files
}

main "$@"
