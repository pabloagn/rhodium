#!/usr/bin/env bash
# assets/colors/visualize.sh

OUTPUT_DIR="/tmp/palette.html"

if [ ! -f colors.nix ]; then
  echo "Error: colors.nix not found in current directory"
  exit 1
fi

echo "Generating color palette visualization..."
nix-build visualize.nix -o result-colors
HTML_FILE="$(readlink -f result-colors)${OUTPUT_DIR}"

if [ ! "$HTML_FILE" ]; then
  echo "Error: Failed to generate visualization"
  exit 1
fi

echo "Opening color visualization in browser..."
if command -v xdg-open &> /dev/null; then
  firefox "$HTML_FILE"
elif command -v open &> /dev/null; then
  open result-colors
else
  echo "Could not open browser automatically."
  echo "Please open this file manually: result-colors"
fi
