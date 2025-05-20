# home/apps/media/torrent/transmission.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.torrent.transmission;
in
{
  imports = [
    ./deluge.nix
    ./deluged.nix
    ./transmission.nix
  ];

  options.rhodium.home.apps.media.torrent.transmission = {
    enable = mkEnableOption "Rhodium's torrent client";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.media.torrent = {
      transmission.enable = true;
      deluge.enable = false;
      deluged.enable = false;
    };
  };
}
