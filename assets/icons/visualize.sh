#! /usr/bin/env bash

OUTPUT_DIR="/tmp/unicode.html"

if [ ! -f unicode.nix ]; then
  echo "Error: unicode.nix not found in current directory"
  exit 1
fi

echo "Generating Unicode character visualization..."
nix-build visualize.nix -o result-unicode

HTML_FILE="$(readlink -f result-unicode)${OUTPUT_DIR}"

if [ ! -f "$HTML_FILE" ]; then
  echo "Error: Failed to generate visualization"
  exit 1
fi

echo "Opening Unicode visualization in browser..."
if command -v firefox &> /dev/null; then
  firefox "$HTML_FILE"
elif command -v xdg-open &> /dev/null; then
  xdg-open "$HTML_FILE"
elif command -v open &> /dev/null; then
  open "$HTML_FILE"
else
  echo "Could not open browser automatically."
  echo "Please open this file manually: $HTML_FILE"
fi
