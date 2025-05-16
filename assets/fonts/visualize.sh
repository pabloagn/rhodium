#!/usr/bin/env bash
# assets/fonts/visualize.sh

OUTPUT_DIR="/tmp/fontpreview.html"

# Check if fonts.nix exists
if [ ! -f fonts.nix ]; then
  echo "Error: fonts.nix not found in current directory"
  exit 1
fi

# Check if visualize.nix exists
if [ ! -f visualize.nix ]; then
  echo "Error: visualize.nix not found in current directory"
  exit 1
fi

# Generate HTML file with Nix
echo "Generating Font visualization..."
nix-build visualize.nix -o result-fonts

# Get the generated file path
HTML_FILE="$(readlink -f result-fonts)${OUTPUT_DIR}"

# Check if the file exists
if [ ! -f "$HTML_FILE" ]; then
  echo "Error: Failed to generate visualization"
  exit 1
fi

# Open the HTML file in the default browser
echo "Opening Font visualization in browser..."
if command -v firefox &>/dev/null; then
  firefox "$HTML_FILE"
elif command -v xdg-open &>/dev/null; then
  xdg-open "$HTML_FILE"
elif command -v open &>/dev/null; then
  open "$HTML_FILE"
else
  echo "Could not open browser automatically."
  echo "Please open this file manually: $HTML_FILE"
fi
