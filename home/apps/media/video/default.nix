# home/apps/media/video/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    # Video players
    {
      name = "mpv";
      pkg = pkgs.mpv;
      description = "Media player based on MPlayer and mplayer2";
    }
    {
      name = "vlc";
      pkg = pkgs.vlc;
      description = "Cross-platform media player and streaming server";
    }

    # Video streaming/servers
    {
      name = "plex";
      pkg = pkgs.plex;
      description = "Media server for photos, music, videos, and more";
    }
    {
      name = "jellyfin";
      pkg = pkgs.jellyfin;
      description = "Media server for photos, music, videos, and more";
    }
    {
      name = "emby";
      pkg = pkgs.emby;
      description = "Media server for photos, music, videos, and more";
    }
    {
      name = "dim";
      pkg = pkgs.dim;
      description = "Media server for photos, music, videos, and more";
    }
    {
      name = "olaris";
      pkg = pkgs.olaris;
      description = "Media server for photos, music, videos, and more";
    }

    # Video editors and capture
    {
      name = "obs-studio";
      pkg = pkgs.obs-studio;
      description = "Free and open source software for video recording and live streaming";
    }
    {
      name = "handbrake";
      pkg = pkgs.handbrake;
      description = "Video transcoder available for Linux, Mac, and Windows";
    }

    # Media downloaders
    {
      name = "yt-dlp";
      pkg = pkgs.yt-dlp;
      description = "Command-line program to download videos from YouTube and other sites";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Video applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
