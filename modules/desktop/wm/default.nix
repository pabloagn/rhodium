# modules/desktop/wm/default.nix

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];
}
