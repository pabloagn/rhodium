# home/apps/media/video/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.video;
in
{
  options.rhodium.apps.media.video = {
    enable = mkEnableOption "Video applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Video players
      mpv
      vlc

      # Video streaming/servers
      plex

      # Video editors and capture
      obs-studio
      handbrake

      # Media downloaders
      tidal-dl
      yt-dlp
    ];
  };
}
