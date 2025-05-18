# home/apps/media/torrent/transmission.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.torrent.transmission;
in
{
  imports = [
    ./deluge.nix
    ./deluged.nix
    ./transmission.nix
  ];

  options.rhodium.apps.media.torrent.transmission = {
    enable = mkEnableOption "Rhodium's torrent client";
  };

  config = mkIf cfg.enable {
    home.apps.media.torrent.transmission.enable = true;
    home.apps.media.torrent.deluge.enable = true;
    home.apps.media.torrent.deluged.enable = true;
  };
}
