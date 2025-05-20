# modules/desktop/wm/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.wm;
in
{
  imports = [
    ./hyprland.nix
  ];

  options.rhodium.system.desktop.wm = {
    enable = mkEnableOption "Rhodium's desktop window manager configuration";
  };

  config = mkIf cfg.enable {
    rhodium.system.desktop.wm = {
      hyprland.enable = true;
    };
  };
}
