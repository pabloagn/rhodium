# home/desktop/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop;
in
{
  imports = [
    ./wm/hyprland.nix
    ./launcher/rofi.nix
    ./bar/waybar.nix
    ./notifications/dunst.nix
  ];
}
