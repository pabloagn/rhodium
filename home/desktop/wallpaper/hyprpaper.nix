{ config, lib, userPreferences, ... }:
# TODO: This needs fixing since we're using a different approach now
let
  wallpaperTheme = userPreferences.theme.wallpaper or "dante";
  wallpapersPath = "${config.xdg.dataHome}/wallpapers/${wallpaperTheme}";

  monitors = [ "eDP-1" "HDMI-A-1" ];

  primaryWallpaper = "${wallpapersPath}/wallpaper-01.jpg";

  # Preload the wallpapers that actually exist
  preloadWallpapers = map
    (i:
      "${wallpapersPath}/wallpaper-${lib.strings.fixedWidthNumber 2 i}.jpg"
    )
    (lib.range 1 6);

  # All monitors use the same wallpaper
  wallpaperAssignments = map
    (monitor:
      "${monitor},${primaryWallpaper}"
    )
    monitors;

in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = preloadWallpapers;
      wallpaper = wallpaperAssignments;
    };
  };
}
