#! /usr/bin/env bash
# scripts/utils/inspect_config.sh

target=${1:-hosts}
nix-instantiate --eval --strict --json --arg target "\"$target\"" scripts/utils/inspect_config.nix | jq -r .
