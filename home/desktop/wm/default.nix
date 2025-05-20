# home/desktop/wm/default.nix

{ config, lib, pkgs, inputs ? {}, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.wm;
in
{
  imports = [
    ./hyprland.nix
    ./hyprcursor.nix
    ./hyprpaper.nix
  ];

  options.rhodium.home.desktop.wm = {
    enable = mkEnableOption "Rhodium's Window Manager";
  };

  config = mkIf cfg.enable {
    rhodium.home.desktop.wm = {
      hyprland.enable = true;
      hyprcursor.enable = true;
      hyprpaper.enable = true;
    };
  };
}
