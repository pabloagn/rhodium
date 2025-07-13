{
  config,
  lib,
  userPreferences,
  host,
  ...
}:
let
  wallpaperTheme = userPreferences.theme.wallpaper or "dante";
  wallpapersPath = "${config.xdg.dataHome}/wallpapers/${wallpaperTheme}";

  # Get monitors from host config
  inherit (host.mainMonitor) monitorID;
  monitors = [
    monitorID
    "HDMI-A-1"
  ]; # Include common monitors

  primaryWallpaper = "${wallpapersPath}/wallpaper-01.jpg";

  # Preload the wallpapers that actually exist using ranges
  preloadWallpapers = map (i: "${wallpapersPath}/wallpaper-${lib.strings.fixedWidthNumber 2 i}.jpg") (
    lib.range 1 6
  );

  # All monitors use the same wallpaper
  wallpaperAssignments = map (monitor: "${monitor},${primaryWallpaper}") monitors;
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
