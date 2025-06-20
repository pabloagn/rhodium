#!/usr/bin/env bash

TARGET_FILE="/home/pabloagn/dev/rhodium/home/assets/colors/chiaroscuro.json"

# jq -r 'paths(scalars) as $p | getpath($p) as $v | select($v|test("^#[0-9a-fA-F]{3,8}$")) | [$v] + $p | @tsv' chiaroscuro.json | awk -F'\t' '{printf "%-15s %-15s %s\n", $1, $2, $3}' | tr '~ ' ' .' | fuzzel --dmenu


table=$(jq -r 'paths(scalars) as $p | getpath($p) as $v | select($v|test("^#[0-9a-fA-F]{3,8}$")) | [$v] + $p | @tsv' "${TARGET_FILE}" | awk -F'\t' '{printf "%-15s %-15s %s\n", $1, $2, $3}')

echo -en "${table}" | fuzzel --dmenu
