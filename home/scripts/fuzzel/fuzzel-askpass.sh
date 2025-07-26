#!/usr/bin/env bash

set -euo pipefail

# --- Functions ---
provide_prompt() {
  fuzzel -I --dmenu --password="*" --prompt-only "Password: " --cache /dev/null
}

provide_prompt
