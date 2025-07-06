#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script interactively removes orphaned configuration directories
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-clean-orphans"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
# Check if directory contains nix store symlinks
has_nix_symlinks() {
    local dir="$1"
    find "$dir" -type l -exec readlink {} \; 2>/dev/null | grep -q "/nix/store/"
}

# Get package names from various sources
get_package_names() {
    local tmpfile
    tmpfile=$(mktemp)
    if command -v nix &>/dev/null; then nix profile list 2>/dev/null | awk -F'#' '{print $2}' | awk -F'.' '{print $NF}' | grep -v '^$' >>"$tmpfile"; fi
    if command -v home-manager &>/dev/null; then home-manager packages 2>/dev/null | awk -F'-' 'NF>1{print $NF}' | grep -v '^$' >>"$tmpfile"; fi
    nix profile list 2>/dev/null | awk '{print $2}' | grep -v '^$' >>"$tmpfile"
    sort -u "$tmpfile"
    rm -f "$tmpfile"
}

# Check if config matches any installed package
is_package_installed() {
    local dirname="$1"
    local installed_list="$2"
    grep -qiF "$dirname" "$installed_list" && return 0
    local variations=("$dirname" "${dirname,,}" "${dirname^^}" "${dirname//-/_}" "${dirname//_/-}")
    for var in "${variations[@]}"; do grep -qiF "$var" "$installed_list" && return 0; done
    return 1
}

# Show directory contents preview
show_contents() {
    local dir="$1"
    local max_files=10
    echo
    cyan "  Directory contents:"
    echo
    local file_count=0
    while IFS= read -r file && [[ $file_count -lt $max_files ]]; do
        local relative="${file#"$dir"/}"
        local indent="    "
        if [[ -L "$file" ]]; then
            local target
            target=$(readlink "$file")
            if [[ "$target" =~ /nix/store/ ]]; then green "$indent├─ $relative → [NIX]"; else yellow "$indent├─ $relative → $target"; fi
        elif [[ -d "$file" ]]; then blue "$indent├─ $relative/"; else echo "$indent├─ $relative"; fi
        ((file_count++))
    done < <(find "$dir" -maxdepth 2 \( -type f -o -type l -o -type d \) ! -path "$dir" | sort)
    local total_files
    total_files=$(find "$dir" -type f -o -type l | wc -l)
    if [[ $total_files -gt $max_files ]]; then echo "    └─ ... and $((total_files - max_files)) more files"; fi
    echo
}

# Clean orphans by category
clean_category() {
    local category="$1"
    shift
    local configs=("$@")
    local removed=0
    local skipped=0
    for config in "${configs[@]}"; do
        IFS='|' read -r name size path <<<"$config"
        echo
        cyan "$BAR_LIGHT"
        case "$category" in
        "unmanaged") yellow "◆ $name [$size] - No Nix symlinks" ;;
        "mixed") yellow "◆ $name [$size] - Mixed managed/unmanaged files" ;;
        "managed") green "◆ $name [$size] - All Nix symlinks (old generation)" ;;
        esac
        show_contents "$path"
        if [[ "$category" == "mixed" ]]; then yellow "  ⚠ WARNING: Contains both managed and unmanaged files"; fi
        if no_or_yes "Remove $name?"; then
            if [[ "$category" != "unmanaged" ]]; then
                red "  ⚠ FINAL CONFIRMATION REQUIRED"
                if ! yes_or_no "  Are you absolutely sure?"; then
                    echo "  → Skipped"
                    ((skipped++))
                    continue
                fi
            fi
            if rm -rf "$path" 2>/dev/null; then
                green "  → Removed successfully"
                ((removed++))
            else red "  → Failed to remove"; fi
        else
            echo "  → Skipped"
            ((skipped++))
        fi
    done
    echo
    echo "Category complete: $removed removed, $skipped skipped"
    return $removed
}

# Main function
main() {
    echo
    yellow "⚠ WARNING: This will permanently delete configuration directories"
    echo "Please ensure you have backups of important configurations"
    echo
    if ! yes_or_no "Continue with orphan detection?"; then
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Cancelled by user."
        exit 0
    fi

    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Detecting orphaned configurations..."
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
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Detection complete! Found $total_orphans orphans."

    echo
    echo "Found $total_orphans orphaned configurations:"
    echo "  • Unmanaged: ${#unmanaged_configs[@]} (safe to remove)"
    echo "  • Mixed: ${#mixed_configs[@]} (review carefully)"
    echo "  • Managed: ${#managed_configs[@]} (from old generations)"
    if [[ $total_orphans -eq 0 ]]; then exit 0; fi

    local total_removed=0
    if [[ ${#unmanaged_configs[@]} -gt 0 ]]; then
        echo
        cyan "$BAR_HEAVY"
        green "▼ UNMANAGED CONFIGURATIONS (Safe to remove)"
        cyan "$BAR_HEAVY"
        if yes_or_no "Review and clean ${#unmanaged_configs[@]} unmanaged configs?"; then
            clean_category "unmanaged" "${unmanaged_configs[@]}"
            total_removed=$?
        fi
    fi
    if [[ ${#mixed_configs[@]} -gt 0 ]]; then
        echo
        cyan "$BAR_HEAVY"
        yellow "◐ MIXED CONFIGURATIONS (Contains managed and unmanaged files)"
        cyan "$BAR_HEAVY"
        if yes_or_no "Review and clean ${#mixed_configs[@]} mixed configs?"; then
            clean_category "mixed" "${mixed_configs[@]}"
            total_removed=$((total_removed + $?))
        fi
    fi
    if [[ ${#managed_configs[@]} -gt 0 ]]; then
        echo
        cyan "$BAR_HEAVY"
        blue "▲ MANAGED CONFIGURATIONS (From old generations)"
        cyan "$BAR_HEAVY"
        if yes_or_no "Review and clean ${#managed_configs[@]} managed configs?"; then
            clean_category "managed" "${managed_configs[@]}"
            total_removed=$((total_removed + $?))
        fi
    fi

    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} CLEANUP COMPLETE\nTotal configurations removed: $total_removed"
    echo
    echo "Space reclaimed: $(du -sh "${HOME_DIR}"/.config 2>/dev/null | cut -f1)"
}

main "$@"
