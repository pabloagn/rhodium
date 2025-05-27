{ lib, config, pkgs, ... }:
let
  pathGenerators = import ../../../../Lib/generators/pathGenerators.nix { inherit config lib pkgs; };
  getWallpaper = category: pathGenerators.generators.getWallpaperPath category;
  # TODO: Eventually we'll have to get the selected wallpaper from the theme
  wallpapers = getWallpaper "dante";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "${wallpapers}/wallpaper-01.jpg"
        "${wallpapers}/wallpaper-02.jpg"
        "${wallpapers}/wallpaper-03.jpg"
        "${wallpapers}/wallpaper-04.jpg"
        "${wallpapers}/wallpaper-05.jpg"
        "${wallpapers}/wallpaper-06.jpg"
      ];
      wallpaper = [
        "eDP-1,${wallpapers}/wallpaper-01.jpg"
        "HDMI-A-1,${wallpapers}/wallpaper-01.jpg"
        "HDMI-A-2,${wallpapers}/wallpaper-01.jpg"
      ];
    };
  };
}
