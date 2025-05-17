# home/apps/utils/notes/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.notes;
in
{
  imports = [
    ./logseq.nix
    ./obsidian.nix
    ./roam.nix
    ./anytype.nix
  ];

  options.rhodium.apps.utils.notes = {
    enable = mkEnableOption "Rhodium's note-taking applications";
  };

  config = mkIf cfg.enable {
  };
}
