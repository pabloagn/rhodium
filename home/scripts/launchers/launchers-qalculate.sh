#!/usr/bin/env bash

if pgrep "qalculate-gtk" > /dev/null; then
    pkill -9 "qalculate-gtk"
else
    qalculate-gtk &
fi
