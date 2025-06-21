#!/usr/bin/env bash

uris=""
for path in "$@"; do
    # Absolute realpath is safest
    uris+="file://$(realpath "$path")"$'\n'
done

# Manually force MIME using --type AND --primary fallback
printf %s "$uris" | wl-copy --type text/uri-list --primary
