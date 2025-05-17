# home/apps/utils/notes/roam.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.notes.roam;
in
{
  options.rhodium.apps.utils.notes.roam = {
    enable = mkEnableOption "Rhodium's Roam Research configuration";
  };

  config = mkIf (config.rhodium.apps.utils.notes.enable && cfg.enable) {
    home.packages = with pkgs; [
      roam-research
    ];
  };
}
