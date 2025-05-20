# home/apps/utils/notes/obsidian.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils.notes.obsidian;
in
{
  options.rhodium.home.apps.utils.notes.obsidian = {
    enable = mkEnableOption "Rhodium's Obsidian configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
