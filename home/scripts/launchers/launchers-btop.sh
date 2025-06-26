#!/usr/bin/env bash

if pgrep "btop" > /dev/null; then
    pkill -9 "btop"
else
    kitty -e btop &
fi
