#!/usr/bin/env bash

if pgrep "calcure" >/dev/null; then
    pkill -9 "calcure"
else
    calcure &
fi
