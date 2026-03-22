# Task 0003: Update Assets Module to Wire Fetched Collections into Symlink Tree

**Status**: Not Started
**Created**: 2026-03-22
**Priority**: HIGH
**Phase**: 2 — Integration

## Overview

Update `home/modules/assets.nix` so that locally-synced wallpaper collections (downloaded by the fetcher from Task 0002) are properly registered, symlinked, and visible to the wallpaper cache builder and fuzzel display menu. Currently the module symlinks the entire `home/assets/wallpapers/` repo directory into `$XDG_DATA_HOME/wallpapers/` as a single recursive symlink from the Nix store. After this task, the module must handle a hybrid model: repo-provided metadata plus S3-fetched image files living outside the Nix store.

## Objectives

1. Refactor the `wallpapers` symlink block in `assets.nix` to handle both Nix store metadata and out-of-store image directories
2. Ensure each enabled collection directory contains both its `metadata.json` (from the repo/Nix store) and the downloaded `.jpg` files (from S3 sync)
3. Generate per-collection `metadata.json` files from `collections.nix` if they don't already exist in the repo
4. Ensure the wallpaper cache builder (`build/common/build-cache-wallpapers.sh`) works with the new directory layout
5. Ensure `swaybg` service and the fuzzel wallpaper switcher continue to function with the new paths

## Implementation

### Revised Symlink Strategy

The current approach:
```
$XDG_DATA_HOME/wallpapers/ -> /nix/store/.../wallpapers/  (single recursive symlink)
```

New approach:
```
$XDG_DATA_HOME/wallpapers/
  william-blake/           (real directory, created by S3 sync)
    metadata.json          (symlink -> Nix store, from repo)
    angel-of-the-revelation-1805.jpg  (real file, from S3 sync)
    ...
  redon/                   (real directory, created by S3 sync)
    metadata.json          (symlink -> Nix store, from repo)
    closed-eyes-1889.jpg   (real file, from S3 sync)
    ...
  default.jpg              (symlink -> Nix store, default wallpaper)
```

### Updated `home/modules/assets.nix`

```nix
# Wallpaper Packs — hybrid model
(mkIf cfg.wallpapers.enable {
  # Symlink default wallpaper and shared assets from Nix store
  xdg.dataFile."wallpapers/default.jpg" = {
    source = "${repoAssetsPath}/wallpapers/default.jpg";
    force = true;
  };

  # Generate and link metadata.json for each enabled collection
  ${lib.concatStringsSep "\n" (map (name:
    let col = collections.${name}; in ''
      xdg.dataFile."wallpapers/${name}/metadata.json" = {
        text = builtins.toJSON {
          collection = name;
          title = col.name;
          description = col.description;
          category = col.category;
          s3Prefix = col.s3Prefix;
        };
        force = true;
      };
    '') cfg.wallpapers.collections)}
})
```

Note: The exact Nix syntax will need adjustment — the above is pseudocode. The real implementation will use `lib.mkMerge` and `lib.listToAttrs` to dynamically generate `xdg.dataFile` entries.

### Verification Script in Activation

After both the symlink creation and S3 sync (Task 0002), add a verification step:

```bash
for col in ${concatStringsSep " " cfg.wallpapers.collections}; do
  DIR="$XDG_DATA_HOME/wallpapers/$col"
  if [ -d "$DIR" ] && [ -f "$DIR/metadata.json" ]; then
    count=$(find "$DIR" -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" | wc -l)
    echo "✓ $col: $count images"
  else
    echo "⚠ $col: directory or metadata missing"
  fi
done
```

### Cache Builder Compatibility

`build/common/build-cache-wallpapers.sh` currently uses:
```bash
fd . "$WALLPAPER_SRC_DIR" -t 'symlink' --and ".jpg"
```

This finds only symlinks (type `symlink`). Since S3-synced files are real files (not symlinks), change to:
```bash
fd . "$WALLPAPER_SRC_DIR" -e ".jpg"
```

This finds both real files and symlinks with `.jpg` extension.

## Files Created/Modified

### Created
None.

### Modified
- `home/modules/assets.nix` — refactor wallpaper symlink block to hybrid model; generate per-collection `metadata.json` from `collections.nix`; update verification activation script
- `build/common/build-cache-wallpapers.sh` — change `fd` filter from `-t 'symlink'` to `-e ".jpg"` so it finds both real files and symlinks

## Success Criteria

1. After `just switch`, each enabled collection has a directory under `~/.local/share/wallpapers/<collection>/` containing both `metadata.json` and image files
2. `rh-update-caches --wallpapers` successfully builds the wallpaper cache with the new layout
3. The fuzzel wallpaper switcher shows all images from all enabled collections
4. `swaybg` can set any wallpaper from the synced collections
5. Disabling a collection and rebuilding removes its directory cleanly
6. The `default.jpg` symlink continues to work as before

## Next Steps

- Task 0004: Remove Committed Wallpaper Binaries from Git History
- Task 0005: Add Collection Submenu to Fuzzel Display Menu
