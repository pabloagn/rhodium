{ config, lib, userPreferences, ... }:
let
  # Get wallpaper theme from user preferences
  wallpaperTheme = userPreferences.theme.wallpaper or "dante";

  # Use the symlinked wallpaper path
  wallpapersPath = "${config.xdg.dataHome}/wallpapers/${wallpaperTheme}";

  # All monitors get the same wallpaper
  monitors = [ "eDP-1" "HDMI-A-1" ];

  # Primary wallpaper
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
