# home/apps/files/krusader.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.files.krusader;
in
{
  options.rhodium.home.apps.files.krusader = {
    enable = mkEnableOption "Krusader file manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      krusader
    ];
  };
}
