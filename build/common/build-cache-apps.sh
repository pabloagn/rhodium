#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Cache builder script for apps
#

COMMON_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${COMMON_DIR}/bootstrap.sh"

# --- Metadata For Fuzzel Apps Cache ---
load_metadata "fuzzel" "apps"

# --- Variables for fuzzel-apps cache ---
PADDING_ARGS="35 20 20" # Column padding: name, type, categories

# --- Build Fuzzel-apps Cache ---
build_cache_apps() {
  local APP_DIR="$HOME/.local/share/applications"
  local CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
  local CACHE_FILE="$CACHE_DIR/formatted_apps.cache"

  print_pending "Building fuzzel-apps cache..."

  mkdir -p "$CACHE_DIR"

  local -a paddings
  read -ra paddings <<<"$PADDING_ARGS"

  declare -A name_map type_map cat_map

  for file in "$APP_DIR"/rh-*.desktop; do
    [[ -f "$file" ]] || continue

    while IFS='=' read -r key value; do
      case "$key" in
      "Name")
        name_map["$file"]="$value"
        ;;
      "X-Entry-Type")
        type_map["$file"]="$value"
        ;;
      "X-Category")
        cat_map["$file"]="$value"
        ;;
      esac
    done <"$file"
  done

  readarray -t sorted_files < <(
    for file in "${!name_map[@]}"; do
      printf '%s\t%s\n' "${name_map[$file]}" "$file"
    done | sort -k1,1 | cut -f2
  )

  {
    for file in "${sorted_files[@]}"; do
      name="${name_map[$file]}"
      entry_type="${type_map[$file]:-app}"

      categories="${cat_map[$file]:-}"
      if [[ -n "$categories" ]]; then
        IFS=';' read -ra cat_array <<<"$categories"
        formatted_cats=""
        for cat in "${cat_array[@]}"; do
          # Trim whitespace and capitalize
          cat="${cat#"${cat%%[![:space:]]*}"}"
          cat="${cat%"${cat##*[![:space:]]}"}"
          [[ -n "$cat" ]] && formatted_cats+="${formatted_cats:+, }${cat^}"
        done
        categories="$formatted_cats"
      else
        categories="App"
      fi

      local formatted_text=""
      local parts=("$(provide_fuzzel_entry) $name" "${entry_type^}" "$categories")
      local num_parts=${#parts[@]}
      local num_paddings=${#paddings[@]}

      for ((i = 0; i < num_parts; i++)); do
        local part="${parts[i]}"
        if ((i < num_paddings)); then
          local pad_to=${paddings[i]}
          formatted_text+=$(printf "%-*s" "$pad_to" "$part")
        else
          formatted_text+="$part"
        fi
        if ((i < num_parts - 1)); then
          formatted_text+=" "
        fi
      done

      printf '%s\t%s\n' "$formatted_text" "$file"
    done
  } >"$CACHE_FILE"

  print_success "Fuzzel-apps cache built"
}
