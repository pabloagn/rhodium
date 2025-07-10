#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-fuzzel-go"
APP_TITLE="Rhodium Go"
PROMPT="Γ (G) I|D|Y|W: "

FUZZEL_WIDTH=120

FIREFOX_PROFILE_PERSONAL="Personal"
FIREFOX_PROFILE_MEDIA="Media"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

open_in_firefox() {
    local url="$1"
    notify "$APP_TITLE" "Opening $url in Firefox..."
    firefox -P "$FIREFOX_PROFILE_PERSONAL" --new-window "$url" &
    disown
}

open_in_firefox_media() {
    local url="$1"
    notify "$APP_TITLE" "Opening $url in Firefox..."
    firefox -P "$FIREFOX_PROFILE_MEDIA" --new-window "$url" &
    disown
}

urlencode() {
    local string="$1"
    printf %s "$string" | jq -sRr @uri
}

search_google() {
    local query="$1"
    if [[ -z "$query" ]]; then
        notify "$APP_TITLE" "No query provided for Google search."
        return 1
    fi
    local encoded_query
    encoded_query=$(urlencode "$query")
    local url="https://www.google.com/search?q=${encoded_query}"
    open_in_firefox "$url"
}

search_google_image() {
    local query="$1"
    if [[ -z "$query" ]]; then
        notify "$APP_TITLE" "No query provided for Google Image search."
        return 1
    fi
    local encoded_query
    encoded_query=$(urlencode "$query")
    local url="https://www.google.com/search?tbm=isch&q=${encoded_query}"
    open_in_firefox "$url"
}

search_duckduckgo() {
    local query="$1"
    if [[ -z "$query" ]]; then
        notify "$APP_TITLE" "No query provided for DuckDuckGo search."
        return 1
    fi
    local encoded_query
    encoded_query=$(urlencode "$query")
    local url="https://duckduckgo.com/?q=${encoded_query}"
    open_in_firefox "$url"
}

search_youtube() {
    local query="$1"
    if [[ -z "$query" ]]; then
        notify "$APP_TITLE" "No query provided for YouTube search."
        return 1
    fi
    local encoded_query
    encoded_query=$(urlencode "$query")
    local url="https://www.youtube.com/results?search_query=${encoded_query}"
    open_in_firefox_media "$url"
}

search_wikipedia() {
    local query="$1"
    if [[ -z "$query" ]]; then
        notify "$APP_TITLE" "No query provided for Wikipedia search."
        return 1
    fi
    local encoded_query
    encoded_query=$(urlencode "$query")
    local url="https://en.wikipedia.org/wiki/Special:Search?search=${encoded_query}"
    open_in_firefox "$url"
}

show_help_menu() {
    notify "$APP_TITLE" "Usage: [<prefix>] <query>" \
        "  (G): Google search (default if no prefix or 'G' is used)" \
        "  I: Google Image search" \
        "  D: DuckDuckGo search" \
        "  Y: YouTube search" \
        "  W: Wikipedia search" \
        "  (Type 'help' for this menu)"
}

main() {
    if ! command -v firefox &>/dev/null; then
        notify "$APP_TITLE" "Error: Firefox is not installed. Please install Firefox."
        exit 1
    fi
    if ! command -v fuzzel &>/dev/null; then
        notify "$APP_TITLE" "Error: fuzzel is not installed. Please install fuzzel."
        exit 1
    fi
    if ! command -v jq &>/dev/null; then
        notify "$APP_TITLE" "Error: jq is not installed. Please install jq for URL encoding."
        exit 1
    fi

    local full_input
    local command_alias
    local query

    full_input=$(fuzzel --dmenu --prompt-only="$PROMPT" -w "$FUZZEL_WIDTH" --search "G ")

    [[ -z "$full_input" ]] && return

    if [[ "$full_input" == *" "* ]]; then
        command_alias="${full_input%% *}"
        query="${full_input#* }"
    else
        command_alias="G"
        query="$full_input"
    fi

    command_alias=$(echo "$command_alias" | tr '[:lower:]' '[:upper:]')

    if [[ "$command_alias" == "G" && "$query" == "G" ]]; then
        query=""
    fi

    case "$command_alias" in
    G)
        search_google "$query"
        ;;
    I)
        search_google_image "$query"
        ;;
    D)
        search_duckduckgo "$query"
        ;;
    Y)
        search_youtube "$query"
        ;;
    W)
        search_wikipedia "$query"
        ;;
    help | -h | --help)
        show_help_menu
        ;;
    *)
        notify "$APP_TITLE" "Unknown command or invalid format: '$full_input'" "Type 'help' for options."
        show_help_menu
        ;;
    esac
}

main
