# Task 0004: Remove Committed Wallpaper Binaries from Git History

**Status**: Not Started
**Created**: 2026-03-22
**Priority**: MEDIUM
**Phase**: 3 — Cleanup

## Overview

The `dante` collection currently has 11 wallpaper JPEGs (~40MB) committed directly in the git repo at `home/assets/wallpapers/dante/`. Now that wallpapers are fetched from S3, these binaries should be removed from the repo and ideally purged from git history to reduce clone size. The other 11 collection directories (aria, desesseintes, dorian, etc.) only contain `metadata.json` stubs — those can remain or be removed since Task 0003 generates metadata from `collections.nix`.

## Objectives

1. Remove all `.jpg`/`.jpeg`/`.png` files from `home/assets/wallpapers/` in the working tree
2. Remove the legacy `wallpapers.nix` local-path registry (replaced by `collections.nix` from Task 0001)
3. Remove the empty collection stub directories (aria, desesseintes, etc.) and their `metadata.json` files since metadata is now generated
4. Optionally rewrite git history to purge the ~40MB of binary data (coordinate with other contributors if any)
5. Update `.gitignore` to prevent accidental re-commit of wallpaper images

## Implementation

### Step 1 — Remove From Working Tree

```bash
# Remove all image files
fd -e jpg -e jpeg -e png . home/assets/wallpapers/ -x rm {}

# Remove legacy stub directories (metadata now generated from collections.nix)
rm -rf home/assets/wallpapers/aria/
rm -rf home/assets/wallpapers/dante/
rm -rf home/assets/wallpapers/desesseintes/
rm -rf home/assets/wallpapers/dorian/
rm -rf home/assets/wallpapers/edmond/
rm -rf home/assets/wallpapers/eurydice/
rm -rf home/assets/wallpapers/fiora/
rm -rf home/assets/wallpapers/maldoror/
rm -rf home/assets/wallpapers/mephisto/
rm -rf home/assets/wallpapers/prospero/
rm -rf home/assets/wallpapers/sylvia/
rm -rf home/assets/wallpapers/tartaglia/

# Remove legacy registry
rm home/assets/wallpapers/wallpapers.nix
```

### Step 2 — Update `.gitignore`

```gitignore
# Wallpaper images — fetched from S3, not stored in repo
home/assets/wallpapers/**/*.jpg
home/assets/wallpapers/**/*.jpeg
home/assets/wallpapers/**/*.png
home/assets/wallpapers/**/*.webp
```

### Step 3 — Optional History Rewrite

```bash
# Only if repo size reduction is important
git filter-repo --path home/assets/wallpapers/ --path-glob '*.jpg' --invert-paths
```

**Warning**: This rewrites all commit SHAs. Only do this if the repo is not shared with others or after coordinating with all contributors.

## Files Created/Modified

### Created
None.

### Modified
- `.gitignore` — add patterns to exclude wallpaper image files
- `home/assets/wallpapers/` — remove all subdirectories and `wallpapers.nix`

### Deleted
- `home/assets/wallpapers/dante/wallpaper-*.jpg` (11 files, ~40MB)
- `home/assets/wallpapers/*/metadata.json` (12 files)
- `home/assets/wallpapers/wallpapers.nix`

## Success Criteria

1. No `.jpg`/`.jpeg`/`.png` files exist under `home/assets/wallpapers/` in the working tree
2. `just check` still passes
3. The wallpaper fetcher (Task 0002) and assets module (Task 0003) do not reference the removed files
4. `.gitignore` prevents accidental re-commit of image files
5. Repo clone size is reduced (after optional history rewrite)

## Next Steps

- Task 0005: Add Collection Submenu to Fuzzel Display Menu
