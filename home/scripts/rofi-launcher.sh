#!/usr/bin/env bash
set -euo pipefail
launch_app() {
  APP_DIR="$XDG_SHARE_APPS"
  ROFI_THEME="$XDG_CONFIG_HOME/rofi/themes/chiaroscuro.rasi"
  local names=()
  local files=()
  while IFS=: read -r file name; do
    # Get the entry type
    entry_type=$(rg -m1 '^X-Entry-Type=' "$file" | cut -d= -f2- || echo "app")
    # Format: Name (entry-type)
    formatted_name="${name#Name=} <i>($entry_type)</i>"
    names+=("$formatted_name")
    files+=("$file")
  done < <(rg -H '^Name=' "$APP_DIR"/rh-*.desktop | sort -t: -k2)
  selected=$(printf '%s\n' "${names[@]}" | rofi -dmenu -i -theme "$ROFI_THEME" -markup-rows)
  [[ -z "$selected" ]] && return
  for i in "${!names[@]}"; do
    if [[ "${names[$i]}" == "$selected" ]]; then
      gtk-launch "$(basename "${files[$i]}" .desktop)" &
      break
    fi
  done
}
launch_app

# #!/usr/bin/env bash

# set -euo pipefail

# launch_app() {
#   APP_DIR="$XDG_SHARE_APPS"
#   ROFI_THEME="$XDG_CONFIG_HOME/rofi/themes/chiaroscuro.rasi"

#   local names=()
#   local files=()

#   while IFS=: read -r file name; do
#     names+=("${name#Name=}")
#     files+=("$file")
#   done < <(rg -H '^Name=' "$APP_DIR"/rh-*.desktop)

#   selected=$(printf '%s\n' "${names[@]}" | sort -t: -k2 | rofi -dmenu -i -theme "$ROFI_THEME")

#   [[ -z "$selected" ]] && return

#   for i in "${!names[@]}"; do
#     if [[ "${names[$i]}" == "$selected" ]]; then
#       gtk-launch "$(basename "${files[$i]}" .desktop)" &
#       break
#     fi
#   done
# }

# launch_app
