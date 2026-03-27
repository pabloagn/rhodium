#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "osmium"

BOOKMARKS_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/rhodium-utils/osmium-bookmarks.json"

if [[ ! -f "$BOOKMARKS_FILE" ]]; then
  notify "$APP_TITLE" "Bookmarks file not found: $BOOKMARKS_FILE"
  exit 1
fi

# --- Build Menu from JSON ---
# Read descriptions (sorted) and URLs into parallel arrays
mapfile -t descriptions < <(jq -r '[.[]] | sort_by(.description) | .[].description' "$BOOKMARKS_FILE")
mapfile -t urls < <(jq -r '[.[]] | sort_by(.description) | .[].url' "$BOOKMARKS_FILE")
mapfile -t profiles < <(jq -r '[.[]] | sort_by(.description) | .[].profile' "$BOOKMARKS_FILE")

# Build options array for decorate_fuzzel_menu
options=()
for i in "${!descriptions[@]}"; do
  options+=("${descriptions[$i]}:open_entry_$i")
done
options+=("Exit:noop")

decorate_fuzzel_menu options

# --- Helper Functions ---
open_url() {
  local url="$1"
  local profile="$2"
  local name="$3"
  notify "$APP_TITLE" "Opening $name..."
  firefox -P "$profile" --new-window "$url" &
  disown
}

noop() {
  :
}

# --- Main Logic ---
main() {
  local line_count
  line_count=$(get_fuzzel_line_count)

  local selected
  selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count")

  [[ -z "$selected" ]] && return

  # Check for Exit
  if [[ "${menu_commands[$selected]:-}" == "noop" ]]; then
    return
  fi

  # Extract index from command name (open_entry_N)
  if [[ "${menu_commands[$selected]:-}" =~ ^open_entry_([0-9]+)$ ]]; then
    local idx="${BASH_REMATCH[1]}"
    open_url "${urls[$idx]}" "${profiles[$idx]}" "${descriptions[$idx]}"
  fi
}

main
