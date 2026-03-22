# Task 0002: Implement S3 Wallpaper Fetcher via Home Manager Activation

**Status**: Not Started
**Created**: 2026-03-22
**Priority**: HIGH
**Phase**: 1 — Fetch Infrastructure

## Overview

Create a Home Manager activation script that downloads wallpaper images from the `rhodium.rh` S3 bucket at switch time, based on the user's selected collections from Task 0001. Images are synced into `$XDG_DATA_HOME/wallpapers/<collection>/` as real files (not Nix store artifacts), using the host's existing AWS SSO session for authentication. A marker-file system ensures collections are only downloaded once unless explicitly force-refreshed.

## Architectural Decision: Activation-Time Sync (not Build-Time Derivation)

There are two ways to pull remote assets into a NixOS system: a build-time derivation or an activation-time script. **This task uses activation-time sync.** Here is why:

**Option A (rejected) — Impure build-time derivation (`__impure = true`)**

A fixed-output derivation would place images in the Nix store, making them fully declarative. However, this approach has critical drawbacks for this use case:

1. **Nix store bloat**: The S3 library is ~1.5GB and growing. Every version of every collection would persist as a separate store path until garbage-collected. Wallpapers are large, static binary blobs — exactly the kind of content the Nix store handles poorly.
2. **Requires `--impure`**: S3 downloads need network access and live AWS SSO credentials, which Nix sandboxed builds cannot provide. Every `just switch` invocation would need `--impure`, breaking the current pure build workflow and every CI/check recipe.
3. **No incremental sync**: Nix derivations are all-or-nothing. If one image is added to a collection upstream, the entire collection re-downloads. `aws s3 sync` natively handles incremental updates.
4. **Credential leakage risk**: An impure derivation that accesses `~/.aws/` risks caching credential paths or session tokens in the derivation closure. Activation scripts run as the user at switch time, where SSO credentials are naturally available and never touch the store.

**Option B (chosen) — Home Manager activation script**

The activation script runs during `just switch` (after `linkGeneration`), using the user's live AWS SSO session to call `aws s3 sync`. This is the right fit because:

1. **Zero store bloat**: Images live in `$XDG_DATA_HOME/wallpapers/`, outside the Nix store. Garbage collection has no effect on them.
2. **Pure builds preserved**: The Nix evaluation and build phases remain fully pure. The S3 sync is a post-build side effect, same category as the existing `verify-assets` activation script already in `assets.nix`.
3. **Incremental by design**: `aws s3 sync` only downloads changed/new files. Marker files add a second layer so entire collections can be skipped if nothing has changed.
4. **Graceful degradation**: If the SSO session is expired, the script warns and exits 0 — the build still succeeds, and previously-synced wallpapers remain available. The user runs `aws sso login` and triggers `just wallpaper-sync` whenever convenient.
5. **Consistent with Rhodium patterns**: The codebase already uses activation scripts for asset verification (`home/modules/assets.nix:83`). This is the same pattern extended to asset fetching.

The trade-off is that wallpaper images are not tracked by Nix — they exist as mutable state. This is acceptable because wallpapers are aesthetic assets, not system configuration. Their absence never breaks a build or a service; at worst, `swaybg` falls back to `default.jpg`.

## Objectives

1. Create a Home Manager activation script that runs `aws s3 sync` for each collection in the user's `assets.wallpapers.collections` list
2. Authenticate via the host's existing AWS SSO session (`rh-admin` profile) — no credentials baked into the Nix store
3. Use sync markers in `$XDG_DATA_HOME/wallpapers/.sync-markers/` so collections are only downloaded once per enable
4. Provide a cleanup script that removes collections the user has disabled
5. Exit gracefully (warning, not failure) if AWS credentials are unavailable

## Implementation

### Activation Script Generator (`home/modules/wallpaper-fetcher.nix`)

```nix
{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.assets.wallpapers;
  collections = import ../assets/wallpapers/collections.nix;

  # Build a shell script that syncs selected collections from S3
  syncScript = pkgs.writeShellScript "rh-wallpaper-sync" ''
    set -euo pipefail

    WALLPAPER_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/wallpapers"
    BUCKET="s3://rhodium.rh"
    PROFILE="rh-admin"
    MARKER_DIR="$WALLPAPER_DIR/.sync-markers"
    mkdir -p "$MARKER_DIR"

    # Check AWS credentials
    if ! ${pkgs.awscli2}/bin/aws sts get-caller-identity --profile "$PROFILE" &>/dev/null; then
      echo "⚠ AWS SSO session expired or not configured. Skipping wallpaper sync."
      echo "  Run: aws sso login --profile rh-admin"
      exit 0
    fi

    ${concatStringsSep "\n" (map (name:
      let col = collections.${name}; in ''
        # --- ${col.name} ---
        TARGET_DIR="$WALLPAPER_DIR/${name}"
        MARKER="$MARKER_DIR/${name}.synced"

        if [ ! -f "$MARKER" ] || [ "''${FORCE_SYNC:-}" = "1" ]; then
          echo "⟳ Syncing collection: ${col.name} (${name})"
          mkdir -p "$TARGET_DIR"
          ${pkgs.awscli2}/bin/aws s3 sync \
            "$BUCKET/${col.s3Prefix}/" \
            "$TARGET_DIR/" \
            --profile "$PROFILE" \
            --no-progress \
            --exclude "manifest.json"
          touch "$MARKER"
          echo "✓ ${col.name} synced"
        else
          echo "· ${col.name} already synced (use FORCE_SYNC=1 to re-download)"
        fi
      '') cfg.collections)}

    echo "✓ All wallpaper collections synced"
  '';

  # Build a cleanup script that removes collections no longer selected
  cleanupScript = pkgs.writeShellScript "rh-wallpaper-cleanup" ''
    set -euo pipefail

    WALLPAPER_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/wallpapers"
    MARKER_DIR="$WALLPAPER_DIR/.sync-markers"
    ENABLED_COLLECTIONS=(${concatStringsSep " " (map (n: ''"${n}"'') cfg.collections)})

    if [ -d "$MARKER_DIR" ]; then
      for marker in "$MARKER_DIR"/*.synced; do
        [ -f "$marker" ] || continue
        col_name="$(basename "$marker" .synced)"
        if ! printf '%s\n' "''${ENABLED_COLLECTIONS[@]}" | grep -qx "$col_name"; then
          echo "⟳ Removing disabled collection: $col_name"
          rm -rf "$WALLPAPER_DIR/$col_name"
          rm -f "$marker"
        fi
      done
    fi
  '';
in
{
  config = mkIf (cfg.enable && cfg.collections != [ ]) {
    # Run sync after Home Manager links are created
    home.activation.sync-wallpaper-collections =
      lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        echo "Syncing wallpaper collections from S3..."
        ${syncScript}
        ${cleanupScript}
      '';
  };
}
```

### AWS Authentication Flow

1. User runs `aws sso login --profile rh-admin` before building (or has an active session)
2. At `just switch` time, the activation script uses the live SSO session to call `aws s3 sync`
3. If the session is expired, the script prints a warning and exits cleanly — no build failure
4. Sync markers in `$XDG_DATA_HOME/wallpapers/.sync-markers/` track which collections have been downloaded
5. Subsequent rebuilds skip already-synced collections unless `FORCE_SYNC=1` is set

### Force Re-Sync

```bash
# Re-download all collections
FORCE_SYNC=1 just switch host_001

# Or manually
FORCE_SYNC=1 ~/.nix-profile/bin/rh-wallpaper-sync
```

## Configuration

### Required
- Active AWS SSO session (`aws sso login --profile rh-admin`)
- S3 bucket `rhodium.rh` accessible via the `rh-admin` profile

### Environment Variables
- `FORCE_SYNC=1` — optional, forces re-download of all collections regardless of sync markers

## Files Created/Modified

### Created
- `home/modules/wallpaper-fetcher.nix` — activation script generator that syncs S3 collections based on user selection

### Modified
- `home/modules/assets.nix` — import `wallpaper-fetcher.nix`; wire the new activation script into the module
- `home/modules/default.nix` — add import for `wallpaper-fetcher.nix` if modules are auto-imported from this directory

## Success Criteria

1. With valid AWS SSO session and `collections = [ "william-blake" ]`, running `just switch host_001` downloads Blake's wallpapers to `~/.local/share/wallpapers/william-blake/`
2. A second `just switch` without changes skips the download (marker file exists)
3. `FORCE_SYNC=1 just switch host_001` re-downloads even if marker exists
4. Expired/missing AWS credentials produce a warning, not a build failure
5. Removing a collection from the user's list and rebuilding deletes the local directory and marker
6. No credentials, tokens, or session data are written to the Nix store

## Next Steps

- Task 0003: Update Assets Module to Wire Fetched Collections into Symlink Tree
- Task 0004: Remove Committed Wallpaper Binaries from Git History
