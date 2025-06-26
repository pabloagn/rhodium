#!/usr/bin/env bash

# Yazi cache generator script - corrected for your setup
# This script pre-generates image caches the way Yazi stores them

dir="${1:-.}"
yellow='\033[0;33m'
green='\033[0;32m'
red='\033[0;31m'
cyan='\033[0;36m'
reset='\033[0m'
sym_pending="⟡"
sym_partial="◐"
sym_success="▲"
sym_down="▼"
sym_bullet="▪"

# Check for required tools
if ! command -v yazi >/dev/null 2>&1; then
    printf "${red}${sym_down} Yazi not found${reset}\n"
    exit 1
fi

if ! command -v convert >/dev/null 2>&1; then
    printf "${red}${sym_down} ImageMagick not found${reset}\n"
    exit 1
fi

printf "${yellow}${sym_pending} Generating Yazi image cache...${reset}\n"

# Get cache directory from config or use default
cache_dir="$HOME/.cache/yazi"
if [ -n "$XDG_CACHE_HOME" ]; then
    cache_dir="$XDG_CACHE_HOME/yazi"
fi

# Create cache directory
mkdir -p "$cache_dir"

printf "${cyan}${sym_bullet} Cache directory: ${cache_dir}${reset}\n"

# Count existing cache files
existing_count=$(find "$cache_dir" -maxdepth 1 -type f -name "????????????????????????????????" 2>/dev/null | wc -l)
printf "${cyan}${sym_bullet} Existing cache files: ${existing_count}${reset}\n"

# Read configuration values from yazi.toml
config_file="$HOME/.config/yazi/yazi.toml"
max_width=2000   # Your config value
max_height=900   # Your config value
quality=70       # Your config value
filter="nearest" # Your config value

# Map filter to ImageMagick
case "$filter" in
    "nearest") im_filter="Point" ;;
    "triangle") im_filter="Triangle" ;;
    "catmull-rom") im_filter="Catrom" ;;
    "gaussian") im_filter="Gaussian" ;;
    "lanczos3") im_filter="Lanczos" ;;
    *) im_filter="Point" ;;
esac

printf "${cyan}${sym_bullet} Max dimensions: ${max_width}x${max_height}${reset}\n"
printf "${cyan}${sym_bullet} Filter: ${filter} (${im_filter})${reset}\n\n"

# Function to generate MD5 hash
generate_yazi_hash() {
    local file_path="$1"
    local mtime="$2"
    
    # Based on the code, Yazi uses: filepath + "//" + mtime + "//0"
    # We need to match exactly how Yazi generates it
    local hash_input="${file_path}//${mtime}//0"
    
    if command -v md5sum >/dev/null 2>&1; then
        echo -n "$hash_input" | md5sum | cut -d' ' -f1
    elif command -v md5 >/dev/null 2>&1; then
        echo -n "$hash_input" | md5 -q
    fi
}

# Process images
generated=0
skipped=0
failed=0
total=0

printf "${yellow}${sym_pending} Scanning for images...${reset}\n"

# Find all image files
while IFS= read -r -d '' image; do
    [ -z "$image" ] && continue
    ((total++))
    
    # Get absolute path
    abs_path=$(realpath "$image" 2>/dev/null)
    [ -z "$abs_path" ] && continue
    
    # Get file modification time
    if [ "$(uname)" = "Darwin" ]; then
        mtime=$(stat -f "%m" "$abs_path" 2>/dev/null)
    else
        mtime=$(stat -c "%Y" "$abs_path" 2>/dev/null)
    fi
    [ -z "$mtime" ] && mtime=0
    
    # Generate hash
    hash=$(generate_yazi_hash "$abs_path" "$mtime")
    cache_file="${cache_dir}/${hash}"
    
    # Check if cache already exists
    if [ -f "$cache_file" ]; then
        ((skipped++))
        continue
    fi
    
    # Determine output format based on input
    # Yazi seems to preserve the original format
    extension="${image##*.}"
    extension="${extension,,}" # lowercase
    
    # Create cache - resize but preserve format
    case "$extension" in
        jpg|jpeg)
            if convert "$image" \
                -resize "${max_width}x${max_height}>" \
                -filter "$im_filter" \
                -quality "$quality" \
                "$cache_file" 2>/dev/null; then
                ((generated++))
            else
                ((failed++))
            fi
            ;;
        png)
            # For PNG, preserve transparency
            if convert "$image" \
                -resize "${max_width}x${max_height}>" \
                -filter "$im_filter" \
                PNG32:"$cache_file" 2>/dev/null; then
                ((generated++))
            else
                ((failed++))
            fi
            ;;
        *)
            # For other formats, convert to PNG to preserve quality
            if convert "$image" \
                -resize "${max_width}x${max_height}>" \
                -filter "$im_filter" \
                PNG32:"$cache_file" 2>/dev/null; then
                ((generated++))
            else
                ((failed++))
            fi
            ;;
    esac
    
done < <(find "$dir" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.gif" -o \
    -iname "*.webp" -o \
    -iname "*.bmp" -o \
    -iname "*.svg" -o \
    -iname "*.avif" -o \
    -iname "*.heif" -o \
    -iname "*.heic" \
\) -print0 2>/dev/null)

# Clear progress line
printf "\r                                                                               \r"

# Show results
if [ $total -eq 0 ]; then
    printf "${yellow}${sym_partial} No images found in ${dir}${reset}\n"
else
    printf "${green}${sym_success} Cache generation complete${reset}\n\n"
    printf "${cyan}Results:${reset}\n"
    printf "  ${sym_bullet} Total images: ${total}\n"
    printf "  ${sym_bullet} Generated: ${generated} new caches\n"
    printf "  ${sym_bullet} Skipped: ${skipped} (already cached)\n"
    [ $failed -gt 0 ] && printf "  ${sym_bullet} Failed: ${failed}\n"
fi

# Show cache info
total_cache=$(find "$cache_dir" -maxdepth 1 -type f -name "????????????????????????????????" 2>/dev/null | wc -l)
cache_size=$(du -sh "$cache_dir" 2>/dev/null | cut -f1)

printf "\n${cyan}Cache info:${reset}\n"
printf "  ${sym_bullet} Total cached files: ${total_cache}\n"
printf "  ${sym_bullet} Cache size: ${cache_size}\n"

# Tips
printf "\n${cyan}💡 Tips:${reset}\n"
printf "  - Clear cache: yazi --clear-cache\n"
printf "  - Manual clear: rm -f ${cache_dir}/*\n"
printf "  - Cache updates when file mtime changes\n"

# Debug info for verification
if [ -n "$DEBUG" ]; then
    printf "\n${yellow}Debug - Recent cache files:${reset}\n"
    ls -lt "$cache_dir" | head -6
fi
