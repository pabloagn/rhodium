#!/usr/bin/env bash

set -euo pipefail

# Validate Environment
: "${RHODIUM:?The RHODIUM environment variable is not set}"
[[ -d "$RHODIUM" ]] ||
    {
        printf 'RHODIUM path “%s” does not exist\n' "$RHODIUM" >&2
        exit 1
    }
[[ -f "$RHODIUM/justfile" ]] ||
    {
        printf 'No justfile found under “%s”\n' "$RHODIUM" >&2
        exit 1
    }

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Configuration ---
load_metadata "fuzzel" "xecute"

# --- Helpers ---
run_fuzzel() {
    local prompt="$1" input="$2" extra="${3:-}"
    if [[ -z "$input" ]]; then
        fuzzel "$(provide_fuzzel_mode)" "$extra" --prompt "$prompt"
    else
        printf '%s\n' "$input" | fuzzel "$(provide_fuzzel_mode)" "$extra" --prompt "$prompt"
    fi
}

ask_argument() {
    local prompt="$1"
    local ans
    ans=$(run_fuzzel "$prompt" "") || return 1
    [[ -n "$ans" ]] || return 1
    printf '%s' "$ans"
}

run_just() {
    (
        cd "$RHODIUM"
        local recipe="$1"
        shift
        notify "$APP_TITLE" "Running: just $recipe $*"
        if just "$recipe" "$@"; then
            notify "$APP_TITLE" "✔ just $recipe $* – completed"
        else
            notify "$APP_TITLE" "✖ just $recipe $* – FAILED"
        fi
    )
}

# --- Parameterised Recipe Helpers ---
for r in fast switch build boot dry dev; do
    eval "
${r}_recipe() {
    local host
    host=\$(ask_argument \"${r^} host: \") || return
    run_just \"$r\" \"\$host\"
}"
done

update_input_recipe() {
    local input
    input=$(ask_argument "Input name: ") || return
    run_just "update-input" "$input"
}

gc_keep_recipe() {
    local gens
    gens=$(ask_argument "Keep how many generations? (default 5): ") || gens=5
    run_just "gc-keep" "$gens"
}

gc_days_recipe() {
    local days
    days=$(ask_argument "Delete after how many days? (default 7): ") || days=7
    run_just "gc-days" "$days"
}

# --- Single Shots ---
simple_recipes=(update flake-info gc health generation check-backups orphans
    untracked clean-orphans clean-backups update-caches rollback
    fmt reload-services source-user-vars)

for r in "${simple_recipes[@]}"; do
    esc=${r//-/_}
    eval "
${esc}_recipe() { run_just \"$r\"; }"
done

# --- Menu Map ---
declare -A menu_options=(
    ["$(provide_fuzzel_entry) Switch Fast (Rhodium)"]="fast_recipe"
    ["$(provide_fuzzel_entry) Switch (Rhodium)"]="switch_recipe"
    ["$(provide_fuzzel_entry) Build (Rhodium)"]="build_recipe"
    ["$(provide_fuzzel_entry) Boot (Rhodium)"]="boot_recipe"
    ["$(provide_fuzzel_entry) Dry (Rhodium)"]="dry_recipe"
    ["$(provide_fuzzel_entry) Dev (Rhodium)"]="dev_recipe"
    ["$(provide_fuzzel_entry) Update (Rhodium)"]="update_recipe"
    ["$(provide_fuzzel_entry) Update Input (Rhodium)"]="update_input_recipe"
    ["$(provide_fuzzel_entry) Flake Info (Rhodium)"]="flake_info_recipe"
    ["$(provide_fuzzel_entry) Garbage-collect All (Rhodium)"]="gc_recipe"
    ["$(provide_fuzzel_entry) GC – Keep N (Rhodium)"]="gc_keep_recipe"
    ["$(provide_fuzzel_entry) GC – Older than Days (Rhodium)"]="gc_days_recipe"
    ["$(provide_fuzzel_entry) Health (Rhodium)"]="health_recipe"
    ["$(provide_fuzzel_entry) Current Generation (Rhodium)"]="generation_recipe"
    ["$(provide_fuzzel_entry) Check Backups (Rhodium)"]="check_backups_recipe"
    ["$(provide_fuzzel_entry) Find Orphans (Rhodium)"]="orphans_recipe"
    ["$(provide_fuzzel_entry) List Untracked (Rhodium)"]="untracked_recipe"
    ["$(provide_fuzzel_entry) Clean Orphans (Rhodium)"]="clean_orphans_recipe"
    ["$(provide_fuzzel_entry) Clean Backups (Rhodium)"]="clean_backups_recipe"
    ["$(provide_fuzzel_entry) Update Caches (Rhodium)"]="update_caches_recipe"
    ["$(provide_fuzzel_entry) Rollback (Rhodium)"]="rollback_recipe"
    ["$(provide_fuzzel_entry) Format (Rhodium)"]="fmt_recipe"
    ["$(provide_fuzzel_entry) Reload Services (Rhodium)"]="reload_services_recipe"
    ["$(provide_fuzzel_entry) Source User Vars (Rhodium)"]="source_user_vars_recipe"
)

# --- Main Loop ---
main() {
    while true; do
        local items=""
        for k in "${!menu_options[@]}"; do
            items+="$k\n"
        done

        local choice
        choice=$(echo -e "${items}$(provide_fuzzel_entry) Exit" |
            fuzzel --dmenu --prompt="$PROMPT" -l 14) || break

        [[ -z "$choice" || "$choice" == "$(provide_fuzzel_entry) Exit" ]] && break

        if fn="${menu_options[$choice]}"; then
            "$fn"
        fi
    done
}

main
