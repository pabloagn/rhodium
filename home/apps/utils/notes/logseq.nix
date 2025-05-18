# home/apps/utilities/notes/logseq.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utilities.notes.logseq;
in
{
  options.rhodium.apps.utilities.notes.logseq = {
    enable = mkEnableOption "Rhodium's Logseq configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      logseq
    ];
  };
}
