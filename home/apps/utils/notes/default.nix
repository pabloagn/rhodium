# home/apps/utils/notes/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils.notes;
in
{
  imports = [
    ./logseq.nix
    ./obsidian.nix
    ./roam.nix
    ./anytype.nix
  ];

  options.rhodium.home.apps.utils.notes = {
    enable = mkEnableOption "Rhodium's note-taking applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.utils.notes = {
      logseq.enable = false;
      obsidian.enable = true;
      roam.enable = false;
      anytype.enable = false;
    };
  };
}
