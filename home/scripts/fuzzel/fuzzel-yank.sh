#!/usr/bin/env bash

set -euo pipefail

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Main Configuration ---
load_metadata "fuzzel" "yank"

# Configuration
MAX_COMMANDS=500
MAX_LEN=50
MAX_LINES=20
MAX_WIDTH=120

options=()

yank_text() {
  local text="$1"
  if ! command -v wl-copy &>/dev/null; then
    notify "$APP_TITLE" "Error: wl-copy is not installed."
    return 1
  fi

  echo -n "$text" | wl-copy
  notify "$APP_TITLE" "Yanked to clipboard:\n$text"
}

shell_commands_menu() {
  if ! command -v atuin &>/dev/null; then
    notify "$APP_TITLE" "Error: atuin is not installed."
    return 1
  fi

  local entries=()

  while IFS= read -r line; do
    IFS='|' read -r time duration command <<<"$line"
    [[ -z "$command" ]] && continue

    # Trim all fields
    time="${time#"${time%%[![:space:]]*}"}"
    time="${time%"${time##*[![:space:]]}"}"
    duration="${duration#"${duration%%[![:space:]]*}"}"
    duration="${duration%"${duration##*[![:space:]]}"}"
    command="${command#"${command%%[![:space:]]*}"}"
    command="${command%"${command##*[![:space:]]}"}"

    short="$command"
    if ((${#short} > "$MAX_LEN")); then
      short="${short:0:"$MAX_LEN"}..."
    fi

    entries+=("[$time] $(printf '%10s' "$duration") → $short"$'\t'"$command")
  done < <(
    atuin search --limit "$MAX_COMMANDS" --format "{time} | {duration} | {command}" "" 2>/dev/null | sort -r | grep -E '^[^|]*\|[^|]*\|'
  )

  if [[ ${#entries[@]} -eq 0 ]]; then
    notify "$APP_TITLE" "No command history found."
    return 1
  fi

  local selected
  selected=$(printf '%s\n' "${entries[@]}" | cut -f1 | fuzzel --dmenu --prompt="$PROMPT" -l "$MAX_LINES" -w "$MAX_WIDTH")

  if [[ -n "$selected" ]]; then
    for entry in "${entries[@]}"; do
      display="${entry%%$'\t'*}"
      full="${entry#*$'\t'}"
      if [[ "$display" == "$selected" ]]; then
        yank_text "$full"
        break
      fi
    done
  fi
}

info_menu() {
  local metadata_file="$HOME/.config/rh-yank/metadata.json"

  if [[ ! -f "$metadata_file" ]]; then
    notify "$APP_TITLE" "Metadata file not found. Creating example at:\n$metadata_file"
    mkdir -p "$(dirname "$metadata_file")"
    cat >"$metadata_file" <<'EOF'
{
  "email": "user@example.com",
  "name": "John Doe",
  "phone": "+1-555-0123",
  "github": "username",
  "address": "123 Main St, City, State",
  "company": "Example Corp",
  "website": "https://example.com"
}
EOF
    return 1
  fi

  if ! jq empty "$metadata_file" 2>/dev/null; then
    notify "$APP_TITLE" "Invalid JSON in metadata file."
    return 1
  fi

  local metadata
  metadata=$(cat "$metadata_file")

  local info_options=()
  local fields
  fields=$(echo "$metadata" | jq -r 'keys[]' 2>/dev/null || true)

  if [[ -z "$fields" ]]; then
    notify "$APP_TITLE" "No fields found in metadata file."
    return 1
  fi

  while read -r field; do
    local value
    value=$(echo "$metadata" | jq -r ".$field" 2>/dev/null)
    if [[ "$value" != "null" && -n "$value" ]]; then
      info_options+=("$field: $value")
    fi
  done <<<"$fields"

  local line_number
  line_number=$(printf '%s\n' "${info_options[@]}" | wc -l)

  if [[ ${#info_options[@]} -eq 0 ]]; then
    notify "$APP_TITLE" "No valid fields found in metadata."
    return 1
  fi

  local selected
  selected=$(printf '%s\n' "${info_options[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_number")

  if [[ -n "$selected" ]]; then
    local field_name value
    field_name=$(echo "$selected" | cut -d':' -f1)
    value=$(echo "$metadata" | jq -r ".$field_name" 2>/dev/null)
    yank_text "$value"
  fi
}

noop() {
  :
}

generate_menu_options() {
  options=()
  options+=("Shell Commands:shell_commands_menu")
  options+=("Info:info_menu")
  options+=("Exit:noop")
}

main() {
  if ! command -v jq &>/dev/null; then
    notify "$APP_TITLE" "Error: jq is not installed. Please install jq to use this script."
    exit 1
  fi
  if ! command -v wl-copy &>/dev/null; then
    notify "$APP_TITLE" "Error: wl-copy is not installed. Please install wl-copy to use this script."
    exit 1
  fi

  generate_menu_options

  decorate_fuzzel_menu options

  local line_count
  line_count=$(get_fuzzel_line_count)

  local selected
  selected=$(printf '%s\n' "${menu_labels[@]}" | fuzzel --dmenu --prompt="$PROMPT" -l "$line_count")

  [[ -z "$selected" ]] && return

  if [[ "$selected" =~ ^---.*---$ ]]; then
    main
    return
  fi

  if [[ -n "${menu_commands[$selected]:-}" ]]; then
    eval "${menu_commands[$selected]}"
  else
    notify "$APP_TITLE" "No command associated with selected option: $selected"
  fi
}

main
