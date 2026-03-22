# Task 0006: Add `just` Recipe for Manual Wallpaper Sync and Management

**Status**: Not Started
**Created**: 2026-03-22
**Priority**: LOW
**Phase**: 5 — Developer Experience

## Overview

Add `just` recipes for manually triggering wallpaper sync, force-refreshing collections, listing available/enabled collections, and rebuilding the wallpaper cache. While the sync happens automatically during `just switch` via the activation script (Task 0002), developers may want to sync wallpapers independently — for example, after running `aws sso login` when the session was expired during the last build.

## Objectives

1. Add `just wallpaper-sync` recipe to trigger the S3 sync script manually
2. Add `just wallpaper-sync-force` to force re-download all collections
3. Add `just wallpaper-list` to show available collections and their sync status
4. Integrate with existing `just` cache recipes so `rh-update-caches --wallpapers` works after new collections are synced

## Implementation

### New `justfile` Recipes

```just
# Sync wallpaper collections from S3 (skips already-synced)
wallpaper-sync:
    @echo "Syncing wallpaper collections..."
    @~/.nix-profile/bin/rh-wallpaper-sync 2>&1 || true

# Force re-download all wallpaper collections from S3
wallpaper-sync-force:
    @echo "Force-syncing all wallpaper collections..."
    @FORCE_SYNC=1 ~/.nix-profile/bin/rh-wallpaper-sync 2>&1 || true

# List all available wallpaper collections and their sync status
wallpaper-list:
    @echo "Wallpaper Collections:"
    @echo "====================="
    @for marker in ~/.local/share/wallpapers/.sync-markers/*.synced 2>/dev/null; do \
        [ -f "$$marker" ] || continue; \
        col=$$(basename "$$marker" .synced); \
        count=$$(find ~/.local/share/wallpapers/$$col -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" 2>/dev/null | wc -l); \
        echo "  ✓ $$col ($$count images)"; \
    done
    @echo ""
    @echo "Run 'just wallpaper-sync' to download enabled collections"
```

## Files Created/Modified

### Created
None.

### Modified
- `justfile` — add `wallpaper-sync`, `wallpaper-sync-force`, and `wallpaper-list` recipes

## Success Criteria

1. `just wallpaper-sync` triggers the sync script and downloads missing collections
2. `just wallpaper-sync-force` re-downloads all collections
3. `just wallpaper-list` shows all synced collections with image counts
4. All recipes handle missing AWS credentials gracefully (warning, not error)
5. After `just wallpaper-sync`, `rh-update-caches --wallpapers` rebuilds the cache with new images

## Next Steps

None — this is the final task in the wallpaper library feature.
