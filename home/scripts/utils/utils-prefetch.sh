#!/usr/bin/env bash

# Check if correct number of arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <repo>"
    echo "Example: $0 pabloagn kanso.nvim"
    exit 1
fi

USERNAME="$1"
REPO="$2"

echo "Fetching latest commit for $USERNAME/$REPO..."

# Get latest commit hash
REV=$(git ls-remote "https://github.com/$USERNAME/$REPO.git" HEAD | cut -f1)

if [ -z "$REV" ]; then
    echo "Error: Could not fetch commit hash. Check username/repo."
    exit 1
fi

echo "Latest commit: $REV"
echo

# Generate SHA256 hash using nix-prefetch-github
echo "Computing SHA256 hash..."
RESULT=$(nix-prefetch-github "$USERNAME" "$REPO" --rev "$REV")

if [ -z "$RESULT" ]; then
    echo "Error: Could not compute SHA256. Make sure nix-prefetch-github is available."
    exit 1
fi

# Extract hash from JSON output
HASH=$(echo "$RESULT" | jq -r '.hash')

if [ -z "$HASH" ] || [ "$HASH" = "null" ]; then
    echo "Error: Could not extract hash from result."
    exit 1
fi

echo
echo "=== Results ==="
echo "{"
echo "  owner = \"$USERNAME\";"
echo "  repo = \"$REPO\";"
echo "  rev = \"$REV\";"
echo "  hash = \"$HASH\";"
echo "};"
