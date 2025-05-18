# home/apps/media/torrent/deluge.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.torrent.deluge;
in
{
  options.rhodium.apps.media.torrent.deluge = {
    enable = mkEnableOption "Rhodium's deluge client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      deluge
    ];
  };
}
