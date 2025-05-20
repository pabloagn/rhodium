# home/desktop/wm/hyprpaper.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.wm.hyprpaper;

  pathsLib = import ../../../lib/modules/paths.nix {
    inherit lib config;
  };

  wallpapersPath = "${pathsLib.rhodium.assets.wallpapers}";
in
{
  options.rhodium.home.desktop.wm.hyprpaper = {
    enable = mkEnableOption "Rhodium's Hyprpaper configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpaper
    ];

    xdg.configFile."hypr/hyprpaper.conf".text = ''
      # Preload assets to memory (careful on memory usage)
      preload = ${wallpapersPath}/phantom/wallpaper-01.jpg
      preload = ${wallpapersPath}/phantom/wallpaper-02.jpg
      preload = ${wallpapersPath}/phantom/wallpaper-03.jpg
      preload = ${wallpapersPath}/phantom/wallpaper-04.jpg
      preload = ${wallpapersPath}/phantom/wallpaper-05.jpg
      preload = ${wallpapersPath}/phantom/wallpaper-06.jpg

      # Set the default wallpaper(s) seen on initial workspace(s)
      wallpaper = eDP-1,${wallpapersPath}/phantom/wallpaper-01.jpg
      wallpaper = HDMI-A-1,${wallpapersPath}/phantom/wallpaper-01.jpg
      wallpaper = HDMI-A-2,${wallpapersPath}/phantom/wallpaper-01.jpg

      # Disable hyprland splash text rendering over the wallpaper
      splash = false
    '';
  };
}
