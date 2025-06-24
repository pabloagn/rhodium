#!/usr/bin/env bash

if pgrep "qalc" > /dev/null; then
    pkill -9 "qalc"
else
    kitty -e qalc &
fi
