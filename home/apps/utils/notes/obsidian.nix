# home/apps/utils/notes/obsidian.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.notes.obsidian;
in
{
  options.rhodium.apps.utils.notes.obsidian = {
    enable = mkEnableOption "Rhodium's Obsidian configuration";
  };

  config = mkIf (config.rhodium.apps.utils.notes.enable && cfg.enable) {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
