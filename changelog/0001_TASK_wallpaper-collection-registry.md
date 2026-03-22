# Task 0001: Define Wallpaper Collection Registry and Per-User Selection

**Status**: Not Started
**Created**: 2026-03-22
**Priority**: HIGH
**Phase**: 0 — Data Model

## Overview

Create a declarative wallpaper collection registry that maps collection names to S3 paths inside the `rhodium.rh` bucket, and expose a per-user option (`assets.wallpapers.collections`) so each user can select which collections to include in their derivation. Currently `home/assets/wallpapers/wallpapers.nix` defines 12 collection stubs (aria, dante, desesseintes, etc.) with local paths, but only `dante` contains actual image files — the rest have empty `metadata.json` files. The S3 bucket holds a much larger library organized under `assets/wallpapers/painters/` and `assets/wallpapers/contemporary/` with ~300+ images.

This task replaces the current flat local-path model with a registry that knows about remote collections, and lets users opt in to specific ones.

## Objectives

1. Define a new Nix attrset (`wallpaperCollections`) as the single source of truth for all available collections, including S3 prefix, local name, description, and category (painters vs contemporary)
2. Add a new NixOS/Home Manager option `assets.wallpapers.collections` (list of collection name strings) to `home/modules/assets.nix`
3. Retain backward compatibility: `assets.wallpapers.enable = true` still works, but now also requires `assets.wallpapers.collections` to specify which packs to download
4. Update `home/assets/wallpapers/wallpapers.nix` to serve as the registry, no longer pointing to local paths with committed images

## Implementation

### Collection Registry (`home/assets/wallpapers/collections.nix`)

```nix
# Declarative registry of all available wallpaper collections.
# Each entry maps a local collection name to its S3 prefix inside the rhodium.rh bucket.
{
  # --- Painters ---
  adolf-hiremy-hirschl = {
    name = "Adolf Hiremy-Hirschl";
    description = "Symbolist painter — Acheron, Odyssey, Sole Witness";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/adolf-hiremy-hirschl";
  };
  bouguereau = {
    name = "William-Adolphe Bouguereau";
    description = "Academic painter — Birth of Venus, Dante and Virgil";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/bouguereau_william_adolphe";
  };
  cabanel = {
    name = "Alexandre Cabanel";
    description = "Academic painter — Fallen Angel, Echo, Birth of Venus";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/cabanel_alexandre";
  };
  frederic-lord-leighton = {
    name = "Frederic Lord Leighton";
    description = "Victorian painter — Flaming June, Cimabue's Madonna";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/frederic-lord-leighton";
  };
  george-frederic-watts = {
    name = "George Frederic Watts";
    description = "Symbolist painter — Hope, Love and Death, The Minotaur";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/george-frederic-watts";
  };
  maurice-denis = {
    name = "Maurice Denis";
    description = "Nabis painter — Psyche panels, Springtime, Wave";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/maurice-denis";
  };
  redon = {
    name = "Odilon Redon";
    description = "Symbolist — The Cyclops, Closed Eyes, Crying Spider";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/redon_odilon";
  };
  roerich = {
    name = "Nicholas Roerich";
    description = "Mystic painter — Himalayas, Last Angel, Kuan-Yin";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/roerich_nicholas";
  };
  thomas-cole = {
    name = "Thomas Cole";
    description = "Hudson River School — Voyage of Life series";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/thomas-cole";
  };
  vrubel = {
    name = "Mikhail Vrubel";
    description = "Symbolist — Demon Seated, Six-Winged Seraphim";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/vrubel_mikhail";
  };
  william-blake = {
    name = "William Blake";
    description = "Romantic visionary — Great Red Dragon, Newton, Pity";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/william-blake";
  };
  william-morris = {
    name = "William Morris";
    description = "Arts & Crafts — Jasmine, Trellis, Willow Bough";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/william-morris";
  };
  wladyslaw-podkowinski = {
    name = "Wladyslaw Podkowinski";
    description = "Symbolist — Ecstasy, Wounded Heron";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/wladyslaw-podkowinski";
  };
  zinaida-serebriakova = {
    name = "Zinaida Serebriakova";
    description = "Realist — Self-Portrait, Ballerinas, Bather";
    category = "painters";
    s3Prefix = "assets/wallpapers/painters/zinaida-serebriakova";
  };

  # --- Contemporary ---
  adrien-olichon = {
    name = "Adrien Olichon";
    description = "Contemporary minimal photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/adrien-olichon";
  };
  christina-deravedisian = {
    name = "Christina Deravedisian";
    description = "Contemporary photography — soft tones";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/christina-deravedisian";
  };
  cole-parrant = {
    name = "Cole Parrant";
    description = "Contemporary photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/cole-parrant";
  };
  dan-cristian = {
    name = "Dan Cristian";
    description = "Contemporary photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/dan-cristian";
  };
  faded-gallery = {
    name = "Faded Gallery";
    description = "Muted tones gallery — 29 images";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/faded-gallery";
  };
  jr-korpa = {
    name = "JR Korpa";
    description = "Abstract textures and organic forms — 20 images";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/jr-korpa";
  };
  mae-mu = {
    name = "Mae Mu";
    description = "Contemporary photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/mae-mu";
  };
  marvin-van-beek = {
    name = "Marvin Van Beek";
    description = "Contemporary photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/marvin-van-beek";
  };
  maxim-berg = {
    name = "Maxim Berg";
    description = "Contemporary photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/maxim-berg";
  };
  mikey-parkin = {
    name = "Mikey Parkin";
    description = "Contemporary photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/mikey-parkin";
  };
  mikita-yo = {
    name = "Mikita Yo";
    description = "Abstract contemporary — 11 images";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/mikita-yo";
  };
  milad-fakurian = {
    name = "Milad Fakurian";
    description = "Abstract gradients and 3D forms — 39 images";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/milad-fakurian";
  };
  oystein-aspelund = {
    name = "Oystein Aspelund";
    description = "Hibernation and Twilight series — ethereal landscapes";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/oystein-aspelund";
  };
  pawel-czerwinski = {
    name = "Pawel Czerwinski";
    description = "Abstract macro textures — 72 images, largest collection";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/pawel-czerwinski";
  };
  ryunosuke-kikuno = {
    name = "Ryunosuke Kikuno";
    description = "Contemporary Japanese photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/ryunosuke-kikuno";
  };
  sinitta-leunen = {
    name = "Sinitta Leunen";
    description = "Contemporary photography — 7 images";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/sinitta-leunen";
  };
  steve-johnson = {
    name = "Steve Johnson";
    description = "Contemporary abstract painting photography";
    category = "contemporary";
    s3Prefix = "assets/wallpapers/contemporary/steve-johnson";
  };
}
```

### Per-User Option (`home/modules/assets.nix`)

Add a new option alongside the existing `assets.wallpapers.enable`:

```nix
options.assets.wallpapers = {
  enable = mkEnableOption "Link wallpapers directory to XDG data home";
  collections = mkOption {
    type = types.listOf types.str;
    default = [ ];
    description = ''
      List of wallpaper collection names to download from S3 and make available.
      Names must match keys in home/assets/wallpapers/collections.nix.
      Example: [ "william-blake" "redon" "pawel-czerwinski" ]
    '';
  };
};
```

### User Config Example (`users/user_001/default.nix`)

```nix
assets = {
  wallpapers = {
    enable = true;
    collections = [
      "william-blake"
      "redon"
      "pawel-czerwinski"
      "oystein-aspelund"
    ];
  };
  colors.enable = true;
  icons.enable = true;
  ascii.enable = true;
};
```

## Configuration

No new environment variables. The collection list is purely declarative in Nix.

## Files Created/Modified

### Created
- `home/assets/wallpapers/collections.nix` — declarative registry mapping collection names to S3 prefixes, categories, and metadata

### Modified
- `home/modules/assets.nix` — add `assets.wallpapers.collections` option (list of strings)
- `home/assets/wallpapers/wallpapers.nix` — deprecate or refactor to import from `collections.nix`
- `users/user_001/default.nix` — add `assets.wallpapers.collections` list

## Success Criteria

1. `collections.nix` contains an entry for every artist/gallery present in the `rhodium.rh` S3 bucket under `assets/wallpapers/`
2. `assets.wallpapers.collections` option is accepted by the module system without evaluation errors
3. `just check` passes with the new option defined
4. User config can specify an arbitrary subset of collections
5. An empty `collections` list results in no wallpapers being fetched (but the option still evaluates cleanly)

## Next Steps

- Task 0002: Implement S3 Wallpaper Fetcher via Home Manager Activation
- Task 0003: Update Assets Module to Wire Fetched Collections into Symlink Tree
