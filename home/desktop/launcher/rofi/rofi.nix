# home/desktop/launcher/rofi/rofi.nix

{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.rofi
  ];
}
