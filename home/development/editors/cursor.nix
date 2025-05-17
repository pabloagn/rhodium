# home/development/editors/cursor.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.cursor;
in
{
  home.packages = with pkgs; [
    code-cursor
  ];
}
