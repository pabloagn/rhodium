#!/usr/bin/env bash

# Variables
# Default app name if not set by including script
: "${APP_TITLE:=DefaultApp}"
FUZZEL_PROMPT="λ"
FUZZEL_ENTRY="⊹"

notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &>/dev/null; then
        notify-send --app-name="$APP_TITLE" "$title" "$message"
    else
        echo "Notification: $title - $message" >&2
    fi
}

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
