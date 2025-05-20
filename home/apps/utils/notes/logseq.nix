# home/apps/utils/notes/logseq.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils.notes.logseq;
in
{
  options.rhodium.home.apps.utils.notes.logseq = {
    enable = mkEnableOption "Rhodium's Logseq configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      logseq
    ];
  };
}
