#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Pre-computes and caches formatted wallpaper metadata for the rhodium-display menu.
#

set -euo pipefail

# --- Configuration ---
WALLPAPER_SRC_DIR="$XDG_DATA_HOME/wallpapers"
PADDING_ARGS="20 35 15"

COMMON_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${COMMON_DIR}/bootstrap.sh"

# --- Metadata For Fuzzel Apps Cache ---
load_metadata "fuzzel" "display"

# --- Main Cache Building Function ---
build_cache_wallpapers() {
  local CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
  local CACHE_FILE="$CACHE_DIR/wallpapers.cache"

  print_pending "Building wallpaper cache..."

  if ! command -v identify &>/dev/null; then
    print_error "'identify' (from ImageMagick) is not installed. Please install it."
    return 1
  fi
  if ! command -v fd &>/dev/null; then
    print_error "'fd' is not installed. Please install it."
    return 1
  fi
  if [[ ! -d "$WALLPAPER_SRC_DIR" ]]; then
    print_error "Wallpaper source directory not found: $WALLPAPER_SRC_DIR"
    return 1
  fi

  mkdir -p "$CACHE_DIR"

  local -a paddings
  read -ra paddings <<<"$PADDING_ARGS"

  {
    fd . "$WALLPAPER_SRC_DIR" -t 'symlink' --and ".jpg" | while read -r file; do
      # For a path like ".../dante/wallpaper-01.jpg":
      # collection becomes "dante"
      collection=$(basename "$(dirname "$file")")
      # name becomes "wallpaper-01"
      name=$(basename "$file" .jpg)

      if [[ "$(dirname "$file")" == "$WALLPAPER_SRC_DIR" ]]; then
        continue
      fi

      dimensions=$(identify -format '%wx%h' "$file" 2>/dev/null || echo "N/A")

      printf '%s\t%s\t%s\t%s\n' "$collection" "$name" "$dimensions" "$file"
    done | sort -f -k1,1 -k2,2 | while IFS=$'\t' read -r collection name dimensions file; do

      local collection_disp="${collection^}"
      local name_disp="${name^}"

      local formatted_text=""
      local parts=("$(provide_fuzzel_entry) $collection_disp" "$name_disp" "$dimensions")
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

  print_success "Wallpaper cache built successfully at $CACHE_FILE"
}
