#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Finds orphaned configuration directories with detailed analysis
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-orphans"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
has_nix_symlinks() { find "$1" -type l -exec readlink {} \; 2>/dev/null | grep -q "/nix/store/"; }

get_package_names() {
  local tmpfile
  tmpfile=$(mktemp)
  if command -v nix &>/dev/null; then nix profile list 2>/dev/null | awk -F'#' '{print $2}' | awk -F'.' '{print $NF}' | grep -v '^$' >>"$tmpfile"; fi
  if command -v home-manager &>/dev/null; then home-manager packages 2>/dev/null | awk -F'-' 'NF>1{print $NF}' | grep -v '^$' >>"$tmpfile"; fi
  nix profile list 2>/dev/null | awk '{print $2}' | grep -v '^$' >>"$tmpfile"
  sort -u "$tmpfile"
  rm -f "$tmpfile"
}

is_package_installed() {
  local dirname="$1"
  local installed_list="$2"
  grep -qiF "$dirname" "$installed_list" && return 0
  local variations=("$dirname" "${dirname,,}" "${dirname^^}" "${dirname//-/_}" "${dirname//_/-}")
  for var in "${variations[@]}"; do grep -qiF "$var" "$installed_list" && return 0; done
  return 1
}

main() {
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Scanning for orphaned configurations..."
  local pkg_list
  pkg_list=$(mktemp)
  get_package_names >"$pkg_list"
  declare -a managed_configs=()
  declare -a unmanaged_configs=()
  declare -a mixed_configs=()

  while IFS= read -r -d '' dir; do
    local dirname
    dirname=$(basename "$dir")
    if is_system_directory "$dirname"; then continue; fi
    if is_package_installed "$dirname" "$pkg_list"; then continue; fi
    local size
    size=$(du -sh "$dir" 2>/dev/null | cut -f1)
    if has_nix_symlinks "$dir"; then
      local total_files=$(find "$dir" -type f -o -type l | wc -l)
      local symlink_files=$(find "$dir" -type l | wc -l)
      if [[ $total_files -eq $symlink_files ]]; then managed_configs+=("$dirname|$size|$dir"); else mixed_configs+=("$dirname|$size|$dir"); fi
    else unmanaged_configs+=("$dirname|$size|$dir"); fi
  done < <(find "${HOME_DIR}/.config" -maxdepth 1 -type d ! -path "${HOME_DIR}/.config" -print0)
  rm -f "$pkg_list"

  local total_orphans=$((${#managed_configs[@]} + ${#unmanaged_configs[@]} + ${#mixed_configs[@]}))
  if [[ $total_orphans -eq 0 ]]; then
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} No orphaned configurations found!"
    return
  fi

  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Found $total_orphans orphaned configurations"

  if [[ ${#unmanaged_configs[@]} -gt 0 ]]; then
    echo
    red "▼ UNMANAGED CONFIGS (${#unmanaged_configs[@]}) - No Nix symlinks, safe to remove"
    cyan "$BAR_LIGHT"
    for config in "${unmanaged_configs[@]}"; do
      IFS='|' read -r name size path <<<"$config"
      printf "   %-30s %10s\n" "$name" "[$size]"
    done
  fi
  if [[ ${#mixed_configs[@]} -gt 0 ]]; then
    echo
    yellow "◐ MIXED CONFIGS (${#mixed_configs[@]}) - Contains both managed and unmanaged files"
    cyan "$BAR_LIGHT"
    for config in "${mixed_configs[@]}"; do
      IFS='|' read -r name size path <<<"$config"
      printf "   %-30s %10s\n" "$name" "[$size]"
    done
  fi
  if [[ ${#managed_configs[@]} -gt 0 ]]; then
    echo
    green "▲ MANAGED CONFIGS (${#managed_configs[@]}) - All symlinks, from old generations"
    cyan "$BAR_LIGHT"
    for config in "${managed_configs[@]}"; do
      IFS='|' read -r name size path <<<"$config"
      printf "   %-30s %10s\n" "$name" "[$size]"
    done
  fi

  echo
  cyan "$BAR_HEAVY"
  echo "SUMMARY:"
  echo "  Total orphans: $total_orphans"
  echo "NEXT STEPS: Run 'just clean-orphans' to interactively remove them."
}

main "$@"
