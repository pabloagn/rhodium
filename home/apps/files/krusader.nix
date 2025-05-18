# home/apps/files/krusader.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.files.krusader;
in
{
  options.rhodium.apps.files.krusader = {
    enable = mkEnableOption "Krusader file manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      krusader
    ];
  };
}
