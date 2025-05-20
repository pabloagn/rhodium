# home/apps/media/torrent/deluged.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.torrent.deluged;
in
{
  options.rhodium.home.apps.media.torrent.deluged = {
    enable = mkEnableOption "Rhodium's deluge daemon";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      deluged
    ];
  };
}
