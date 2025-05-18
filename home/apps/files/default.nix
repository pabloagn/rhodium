# home/apps/files/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.files;
in
{

  imports = [
    ./thunar.nix
    ./nautilus.nix
    ./krusader.nix
    ./dolphin.nix
  ];

  options.rhodium.apps.files = {
    enable = mkEnableOption "File management applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.files.thunar.enable = true;
    rhodium.apps.files.nautilus.enable = false;
    rhodium.apps.files.krusader.enable = false;
    rhodium.apps.files.dolphin.enable = false;
  };
}
