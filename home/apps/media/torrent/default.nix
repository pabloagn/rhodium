# home/apps/media/torrent/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.torrent;
in
{
  imports = [
    ./deluge.nix
    ./deluged.nix
    ./transmission.nix
  ];

  options.rhodium.apps.media.torrent = {
    enable = mkEnableOption "Rhodium's torrent applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.media.torrent.deluge.enable = false;
    rhodium.apps.media.torrent.deluged.enable = true;
    rhodium.apps.media.torrent.transmission.enable = false;
  };
}
