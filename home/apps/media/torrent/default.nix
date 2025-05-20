# home/apps/media/torrent/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.torrent;
in
{
  imports = [
    ./deluge.nix
    ./deluged.nix
    ./transmission.nix
  ];

  options.rhodium.home.apps.media.torrent = {
    enable = mkEnableOption "Rhodium's torrent applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.media.torrent = {
      deluge.enable = false;
      deluged.enable = true;
      transmission.enable = false;
    };
  };
}
