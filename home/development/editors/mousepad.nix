# home/development/editors/mousepad.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.mousepad;
in
{
  home.packages = with pkgs; [
    mousepad
  ];
}
