# home/desktop/wm/default.nix

{ config, lib, pkgs, inputs ? {}, ... }:

with lib;
let
  cfg = config.rhodium.desktop.wm;
in
{
  imports = [
    ./hyprland.nix
    ./hyprcursor.nix
  ];

  options.rhodium.desktop.wm = {
    enable = mkEnableOption "Rhodium's Window Manager";
  };

  config = mkIf cfg.enable {
    rhodium.desktop.wm.hyprland.enable = true;
    rhodium.desktop.wm.hyprcursor.enable = true;
  };
}
