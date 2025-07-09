#!/usr/bin/env bash
#
# fastfetch-splash  — show Fastfetch with no prompt underneath

set -euo pipefail

tput smcup      # 1. enter the terminal’s alternate screen buffer
tput civis      #    hide the cursor (optional, looks cleaner)
clear           #    start with a blank canvas

fastfetch       # 2. draw the picture 🎨

# 3. wait silently for a single key before giving control back
read -rsn1      # -r: raw, -s: silent, -n1: one character

tput cnorm      # show cursor again
tput rmcup      # 4. leave the alternate screen → your old prompt returns

