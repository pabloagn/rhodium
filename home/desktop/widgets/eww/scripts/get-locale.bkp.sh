#!/usr/bin/env bash

layouts_cache=""

niri msg --json event-stream | while IFS= read -r line; do
    if [[ "$line" == *"KeyboardLayoutsChanged"* ]]; then
        layouts_cache=$(echo "$line" | jq -c '.KeyboardLayoutsChanged.keyboard_layouts.names')
        idx=$(echo "$line" | jq -r '.KeyboardLayoutsChanged.keyboard_layouts.current_idx')
        echo "$layouts_cache" | jq -r ".[$idx]"
    elif [[ "$line" == *"KeyboardLayoutSwitched"* ]] && [[ -n "$layouts_cache" ]]; then
        idx=$(echo "$line" | jq -r '.KeyboardLayoutSwitched.idx')
        echo "$layouts_cache" | jq -r ".[$idx]"
    fi
done
