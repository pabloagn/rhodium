# home/apps/media/audio/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    # Clients
    {
      name = "navidrome";
      pkg = pkgs.navidrome;
      description = "A self-hosted music streaming server and web client";
    }
    {
      name = "beets";
      pkg = pkgs.beets;
      description = "A music library manager and tagger";
    }
    {
      name = "funkwhale";
      pkg = pkgs.funkwhale;
      description = "A music streaming server and web client";
    }
    {
      name = "koel";
      pkg = pkgs.koel;
      description = "A music streaming server and web client";
    }

    # Players
    {
      name = "clementine";
      pkg = pkgs.clementine;
      description = "Multi-platform music player and library organizer";
    }
    {
      name = "spotify";
      pkg = pkgs.spotify;
      description = "Spotify music streaming client";
    }
    {
      name = "plexamp";
      pkg = pkgs.plexamp;
      description = "Beautiful Plex music player for audiophiles";
    }
    {
      name = "tidal";
      pkg = [ pkgs.tidal-hifi pkgs.tidal-dl ];
      description = "TIDAL music streaming client and downloader";
    }
    {
      name = "easyeffects";
      pkg = pkgs.easyeffects;
      description = "Audio effects for PipeWire applications";
    }
    {
      name = "audacious";
      pkg = pkgs.audacious;
      description = "Lightweight audio player";
    }
    {
      name = "playerctl";
      pkg = pkgs.playerctl;
      description = "Command-line utility for controlling media players";
    }
    {
      name = "audacity";
      pkg = pkgs.audacity;
      description = "Multi-track audio editor and recorder";
    }

    # Audiobooks
    {
      name = "Audiobookshelf";
      pkg = pkgs.audiobookshelf;
      description = "Audiobook server for managing and playing your audiobooks";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's audio applications";
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
