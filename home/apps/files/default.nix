# home/apps/files/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.files;
in
{

  imports = [
    ./thunar.nix
    ./nautilus.nix
    ./krusader.nix
    ./dolphin.nix
  ];

  options.rhodium.home.apps.files = {
    enable = mkEnableOption "File management applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.files.thunar.enable = true;
    rhodium.home.apps.files.nautilus.enable = false;
    rhodium.home.apps.files.krusader.enable = false;
    rhodium.home.apps.files.dolphin.enable = false;
  };
}
