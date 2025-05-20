#!/usr/bin/env bash

PROJECT_ROOT="/home/pabloagn/rhodium"

# Check if correct arguments are provided
if [[ "$1" != "-d" || -z "$2" ]]; then
    echo "Usage: $0 -d <directory>"
    exit 1
fi

TARGET_DIR="$2"
OUTPUT_FILE="${PROJECT_ROOT}/PROJECT.txt"

# Create or clear the output file
> "$OUTPUT_FILE"

# Print the directory tree to the output file with a proper tree structure
echo "=== PROJECT DIRECTORY TREE ===" >> "$OUTPUT_FILE"

# Use the 'tree' command if available, otherwise fallback to a more basic approach
if command -v tree &> /dev/null; then
    # Using tree command with relative paths
    (cd "$PROJECT_ROOT" && tree -I ".git" --noreport) >> "$OUTPUT_FILE"
else
    # Fallback method using find and a simple formatting approach
    (cd "$PROJECT_ROOT" && find . -not -path "*/\.*" | sort | while read -r line; do
        indent=$(($(echo "$line" | grep -o "/" | wc -l) - 1))
        spaces=$(printf '%*s' $((indent*2)) '')
        name=$(basename "$line")
        echo "${spaces}├── $name" >> "$OUTPUT_FILE"
    done)
fi

echo "" >> "$OUTPUT_FILE"

# Concatenate all files under the specified directory
echo "=== CONCATENATED FILES FROM $TARGET_DIR ===" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Find all regular files under the target directory and concatenate them
find "${PROJECT_ROOT}/${TARGET_DIR#./}" -type f -not -path "*/\.*" | sort | while read -r file; do
    # Get relative path from project root
    rel_path="${file#"$PROJECT_ROOT"/}"
    echo "### FILE: $rel_path ###" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "### END OF FILE: $rel_path ###" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

echo "Output saved to $OUTPUT_FILE"
