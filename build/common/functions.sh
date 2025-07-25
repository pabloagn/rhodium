#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Helper functions for executing actions and providing variables not related to formatting
#

# --- Variables ---
: "${APP_NAME:=DefaultApp}"
: "${APP_TITLE:=DefaultApp}"
FUZZEL_PROMPT="λ"
FUZZEL_ENTRY="⊹"

# --- Notify To Client ---
notify() {
  local title="$1"
  local message="$2"
  shift 2
  if command -v notify-send &>/dev/null; then
    notify-send --app-name="$APP_NAME" "$title" "$message" "$@"
  else
    echo "Notification: $title - $message" >&2
  fi
}

# --- Copy Content To Clipboard ---
copy_to_clipboard() {
  local text="$1"
  if command -v wl-copy &>/dev/null; then
    echo -n "$text" | wl-copy
    return 0
  elif command -v xclip &>/dev/null; then
    echo -n "$text" | xclip -selection clipboard
    return 0
  else
    return 1
  fi
}

# Add a blank space after the symbol
provide_fuzzel_prompt() {
  printf "%s " "$FUZZEL_PROMPT"
}

# Do not add blank space on this instance
provide_fuzzel_entry() {
  echo "$FUZZEL_ENTRY"
}

# Do not add blank space on this instance
provide_fuzzel_mode() {
  echo "--dmenu"
}

# Populate fuzzel menu from raw "Label:command" array
decorate_fuzzel_menu() {
  local -n raw_options="$1"
  menu_labels=()
  declare -gA menu_commands=()

  for entry in "${raw_options[@]}"; do
    local label="${entry%%:*}"
    local command="${entry##*:}"
    local decorated="${FUZZEL_ENTRY} ${label}"
    menu_labels+=("$decorated")
    menu_commands["$decorated"]="$command"
  done
}

# Return the number of non-empty menu_labels (used for --lines argument)
get_fuzzel_line_count() {
  local count=0
  for label in "${menu_labels[@]}"; do
    [[ -n "$label" ]] && ((count++))
  done
  echo "$count"
}

load_metadata() {
  local group="$1"
  local key="$2"
  local metadata_file="${XDG_DATA_HOME:-$HOME/.local/share}/rhodium-utils/metadata.json"

  if [[ ! -f "$metadata_file" ]]; then
    echo "Metadata file not found: $metadata_file" >&2
    return 1
  fi

  # Parse values using jq
  APP_NAME=$(jq -r --arg g "$group" --arg k "$key" '.[$g][$k].name' "$metadata_file")
  PROMPT=$(jq -r --arg g "$group" --arg k "$key" '.[$g][$k].prompt' "$metadata_file")
  APP_TITLE=$(jq -r --arg g "$group" --arg k "$key" '.[$g][$k].title' "$metadata_file")

  # Validate all were found
  if [[ -z "$APP_NAME" || -z "$PROMPT" || -z "$APP_TITLE" || "$APP_NAME" == "null" ]]; then
    echo "Failed to load metadata for $group/$key from $metadata_file" >&2
    return 1
  fi
}
