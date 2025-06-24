#!/usr/bin/env bash

set -euo pipefail

launch_app() {
    APP_DIR="$HOME/.local/share/applications"
    ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"
    local names=()
    local files=()

    # Parse all desktop files in a single pass
    declare -A name_map type_map cat_map

    # Read all desktop files once and extract all fields
    for file in "$APP_DIR"/rh-*.desktop; do
        [[ -f "$file" ]] || continue

        # Parse the file in a single pass
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

    # Sort files by name
    readarray -t sorted_files < <(
        for file in "${!name_map[@]}"; do
            printf '%s\t%s\n' "${name_map[$file]}" "$file"
        done | sort -k1,1 | cut -f2
    )

    # Build arrays in sorted order
    for file in "${sorted_files[@]}"; do
        name="${name_map[$file]}"
        entry_type="${type_map[$file]:-app}"

        # Parse and format categories
        categories="${cat_map[$file]:-}"
        if [[ -n "$categories" ]]; then
            # Split by semicolon, capitalize each, join with comma
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
            categories="app"
        fi

        formatted_name="⊹ ${name} <i>(${entry_type^})</i> <i>(${categories})</i>"
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
