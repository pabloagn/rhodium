# Task 0005: Add Collection Submenu to Fuzzel Display Menu

**Status**: Not Started
**Created**: 2026-03-22
**Priority**: HIGH
**Phase**: 4 — UX

## Overview

Add a new intermediate submenu to the fuzzel display wallpaper switcher. Currently, selecting "Switch Wallpapers" in the display menu (Caps Lock + D) jumps directly to a flat list of all wallpapers across all collections (showing Collection, Name, Resolution). With the new S3-backed library potentially containing 300+ images across 30+ collections, this flat list becomes unwieldy. This task inserts a collection picker between the main display menu and the per-wallpaper list.

### New Flow

```
[Main Display Menu]
  Sweet Dreams
  Rise & Shine
  Turn Off/On displays...
  Mirror displays...
  Switch Wallpapers    <-- user selects this
  Exit

[Collection Picker]       <-- NEW submenu
  ◌ William Blake         (16 wallpapers)
  ◌ Odilon Redon          (32 wallpapers)
  ◌ Pawel Czerwinski       (72 wallpapers)
  ◌ Oystein Aspelund       (60 wallpapers)
  ← Back

[Wallpaper List]          <-- existing menu, filtered to selected collection
  ◌ William Blake    Angel of the Revelation 1805    3609x2400
  ◌ William Blake    Great Red Dragon                2843x3300
  ...
  ← Back
```

## Objectives

1. Create a collection picker submenu that lists all enabled collections with wallpaper counts
2. When a collection is selected, show the existing wallpaper list filtered to that collection only
3. Add a "← Back" option to return from the wallpaper list to the collection picker, and from the collection picker to the main display menu
4. Update the wallpaper cache to support per-collection filtering
5. Maintain the same visual style and fuzzel configuration (icons, padding, prompt) as the existing menus

## Implementation

### Updated `switch_wallpaper()` in `home/scripts/fuzzel/fuzzel-display.sh`

```bash
switch_wallpaper() {
  local target_dir="/var/tmp/current-wallpaper"
  local CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/$APP_NAME"
  local CACHE_FILE="$CACHE_DIR/wallpapers.cache"

  if [[ ! -f "$CACHE_FILE" ]]; then
    notify "$APP_TITLE" "Wallpaper cache not found!" "Please run the corresponding cache builder recipe."
    return 1
  fi

  # --- Collection Picker Loop ---
  while true; do
    # Build collection list with wallpaper counts from cache
    local collection_menu
    collection_menu=$(awk -F'\t' '{print $1}' "$CACHE_FILE" \
      | awk '{print $2}' \
      | sort -f \
      | uniq -c \
      | awk '{printf "%s (%d wallpapers)\n", $2, $1}' \
      | sort -f)

    # Add back option
    collection_menu=$(printf '%s\n%s' "$collection_menu" "← Back")

    local selected_collection
    selected_collection=$(printf '%s\n' "$collection_menu" | fuzzel --dmenu -p "Collection: " -l 15 -w 60)

    [[ -z "${selected_collection:-}" ]] && break
    [[ "$selected_collection" == "← Back" ]] && break

    # Extract just the collection name (strip count suffix)
    local col_name
    col_name=$(echo "$selected_collection" | sed 's/ ([0-9]* wallpapers)//')

    # --- Wallpaper List Loop (filtered to collection) ---
    while true; do
      local filtered_lines
      filtered_lines=$(awk -F'\t' -v col="$col_name" '$1 ~ col {print $0}' "$CACHE_FILE")

      if [[ -z "$filtered_lines" ]]; then
        notify "$APP_TITLE" "No wallpapers found for collection: $col_name"
        break
      fi

      # Add back option to wallpaper list
      local wallpaper_menu
      wallpaper_menu=$(printf '%s\n%s' "$(echo "$filtered_lines" | cut -d$'\t' -f1)" "← Back")

      local selected_line
      selected_line=$(printf '%s\n' "$wallpaper_menu" | fuzzel --dmenu -p "$PROMPT" -l 10 -w 85)

      [[ -z "${selected_line:-}" ]] && break
      [[ "$selected_line" == "← Back" ]] && break

      local wallpaper_path
      wallpaper_path=$(echo "$filtered_lines" | awk -F'\t' -v sel="$selected_line" '$1 == sel { print $2; exit }')

      if [[ -n "$wallpaper_path" && -f "$wallpaper_path" ]]; then
        ln -sf "$wallpaper_path" "$target_dir"
        notify "$APP_TITLE" "Setting wallpaper:\n◌ $(basename "$wallpaper_path")"

        niri msg action do-screen-transition --delay-ms 400
        systemctl --user restart rh-swaybg.service
      else
        notify "$APP_TITLE" "Could not find file path for selection."
      fi
    done
  done
}
```

### Cache Format Update

The wallpaper cache (`build/common/build-cache-wallpapers.sh`) already includes the collection name as the first column. The existing format is:

```
<icon> Collection    Name    Resolution\t/path/to/file.jpg
```

No structural change is needed to the cache format. The collection picker extracts unique collection names and counts from column 1.

### Fuzzel Styling Consistency

The collection picker should use:
- Same icon prefix as other entries (`provide_fuzzel_entry`)
- Same prompt style but with "Collection: " prefix
- Line count of 15 (to accommodate up to ~30 collections)
- Width of 60 (narrower than the wallpaper detail view since less data)

## Files Created/Modified

### Created
None.

### Modified
- `home/scripts/fuzzel/fuzzel-display.sh` — replace `switch_wallpaper()` function with two-level menu: collection picker → filtered wallpaper list, both with "← Back" navigation

## Success Criteria

1. Selecting "Switch Wallpapers" from the display menu shows a collection picker, not a flat wallpaper list
2. Each collection entry shows the collection name and wallpaper count
3. Selecting a collection shows only wallpapers from that collection
4. "← Back" returns to the previous menu level at each stage
5. Selecting a wallpaper still triggers `swaybg` restart and Niri screen transition
6. The menu is responsive and renders correctly with 30+ collections
7. Empty collections (no images synced yet) show an appropriate message

## Next Steps

- Task 0006: Add `just` Recipe for Manual Wallpaper Sync
