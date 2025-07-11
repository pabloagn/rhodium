#!/usr/bin/env bash

# Variables
# Default app name if not set by including script
: "${APP_NAME:=DefaultApp}"
: "${APP_TITLE:=DefaultApp}"
FUZZEL_PROMPT="λ"
FUZZEL_ENTRY="⊹"

# --- Shared Functions ---
notify() {
    # Notify to client
    local title="$1"
    local message="$2"
    shift 2
    if command -v notify-send &>/dev/null; then
        notify-send --app-name="$APP_NAME" "$title" "$message" "$@"
    else
        echo "Notification: $title - $message" >&2
    fi
}

copy_to_clipboard() {
    # Copy content to clipboard
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

load_metadata() {
    local group="$1"
    local key="$2"
    local metadata_file="${XDG_DATA_HOME:-$HOME/.local/share}/rhodium-utils/metadata.json"

    if [[ ! -f "$metadata_file" ]]; then
        echo "Metadata file not found: $metadata_file" >&2
        return 1
    fi

    # Parse values using jq
    APP_NAME=$(jq -r --arg g "$group" --arg k "$key" '.[$g][$k].name' "$metadata_file")
    PROMPT=$(jq -r --arg g "$group" --arg k "$key" '.[$g][$k].prompt' "$metadata_file")
    APP_TITLE=$(jq -r --arg g "$group" --arg k "$key" '.[$g][$k].title' "$metadata_file")

    # Validate all were found
    if [[ -z "$APP_NAME" || -z "$PROMPT" || -z "$APP_TITLE" || "$APP_NAME" == "null" ]]; then
        echo "Failed to load metadata for $group/$key from $metadata_file" >&2
        return 1
    fi
}
