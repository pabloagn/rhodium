#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# These are helper functions for executing actions and providing variables not related to formatting
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

provide_fuzzel_prompt() {
    # Add a blank space after the symbol
    printf "%s " "$FUZZEL_PROMPT"
}

provide_fuzzel_entry() {
    # Do not add blank space on this instance
    echo "$FUZZEL_ENTRY"
}

provide_fuzzel_mode() {
    # Do not add blank space on this instance
    echo "--dmenu"
}

decorate_fuzzel_menu() {
    # Populate fuzzel menu from raw "Label:command" array
    # Usage:
    #   decorate_fuzzel_menu raw_array[@]
    # After calling, two variables will be available:
    #   - menu_labels (ordered list of decorated entries)
    #   - menu_commands (map of decorated entries -> command names)

    local -n raw_options="$1" # Reference to the input array
    menu_labels=()
    declare -gA menu_commands=() # Global associative array

    for entry in "${raw_options[@]}"; do
        local label="${entry%%:*}"
        local command="${entry##*:}"
        local decorated="${FUZZEL_ENTRY} ${label}"
        menu_labels+=("$decorated")
        menu_commands["$decorated"]="$command"
    done
}

get_fuzzel_line_count() {
    # Returns the number of non-empty menu_labels (used for --lines argument)

    local count=0
    for label in "${menu_labels[@]}"; do
        [[ -n "$label" ]] && ((count++))
    done
    echo "$count"
}
