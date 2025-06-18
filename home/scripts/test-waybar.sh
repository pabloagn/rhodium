#!/usr/bin/env bash

pkill -SIGUSR2 waybar
# NOTE: This is used for when waybar refuses to appear
# nohup waybar > /dev/null 2>&1 &
