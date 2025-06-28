#!/usr/bin/env bash

if pgrep "tv" >/dev/null; then
    pkill -9 "tv"
else
    # Set terminal emulator (use $TERMINAL or fallback)
    TERM=''${TERMINAL:-kitty}

    # Launch television in the terminal with proper sizing
    exec $TERM --class television-launcher --title "Television Picker" -e tv "$@"
fi
