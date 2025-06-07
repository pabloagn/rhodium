#!/usr/bin/env bash

set -euo pipefail

launch_app() {
  APP_DIR="$HOME/.local/share/applications"
  ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

  local names=()
  local files=()

  # Get all Names in one call
  declare -A name_map
  while IFS=: read -r file name; do
    name_map["$file"]="${name#Namrofi-wallpaper.she=}"
  done < <(rg -H '^Name=' "$APP_DIR"/rh-*.desktop | sort -t: -k2)

  # Get all Entry-Types in one call
  declare -A type_map
  while IFS=: read -r file type; do
    type_map["$file"]="${type#X-Entry-Type=}"
  done < <(rg -H '^X-Entry-Type=' "$APP_DIR"/rh-*.desktop)

  # Get all Categories in one call
  declare -A cat_map
  while IFS=: read -r file type; do
    cat_map["$file"]="${type#X-Category=}"
  done < <(rg -H '^X-Category=' "$APP_DIR"/rh-*.desktop)

  # Create sorted array of files by name
  local sorted_files=()
  while IFS=: read -r file name; do
    sorted_files+=("$file")
  done < <(rg -H '^Name=' "$APP_DIR"/rh-*.desktop | sort -t: -k2)

  # Build arrays in sorted order
  for file in "${sorted_files[@]}"; do
    entry_type="${type_map[$file]:-app}"
    entry_cat="${cat_map[$file]:-app}"
    formatted_name="⊹ ${name_map[$file]} <i>(${entry_type^})</i> <i>(${entry_cat^})</i>"
    names+=("$formatted_name")
    files+=("$file")
  done

  selected=$(printf '%s\n' "${names[@]}" | rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)

  [[ -z "$selected" ]] && return

  # Direct lookup
  for i in "${!names[@]}"; do
    if [[ "${names[$i]}" == "$selected" ]]; then
      gtk-launch "$(basename "${files[$i]}" .desktop)" &
      break
    fi
  done
}

launch_app
