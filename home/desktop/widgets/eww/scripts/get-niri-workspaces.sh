#!/usr/bin/env bash

set -euo pipefail

CURRENT_WORKSPACES=$(unbuffer niri msg --json workspaces | jq -c 'sort_by(.idx)')

echo "$CURRENT_WORKSPACES"

unbuffer niri msg --json event-stream | while read -r line; do
    event=$(echo "$line" | jq -c '.WorkspacesChanged // .WorkspaceActivated // empty' 2>/dev/null || true)
    if [[ -z "$event" ]]; then
        continue
    fi
    if new_workspaces=$(echo "$event" | jq -e '.workspaces' 2>/dev/null); then
        CURRENT_WORKSPACES=$(echo "$new_workspaces" | jq 'sort_by(.idx)')
        echo "$CURRENT_WORKSPACES" | jq -c .
    elif activation=$(echo "$event" | jq -e 'select(.id and .focused)' 2>/dev/null); then
        id=$(echo "$activation" | jq '.id')
        focused=$(echo "$activation" | jq '.focused')
        CURRENT_WORKSPACES=$(echo "$CURRENT_WORKSPACES" | jq --argjson id "$id" --argjson focused "$focused" '
            map(if .id == $id then .is_focused = $focused else .is_focused = false end)
            | sort_by(.idx)
        ')
        echo "$CURRENT_WORKSPACES" | jq -c .
    fi
done
