# home/apps/media/audio/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.audio;
in
{
  imports = [
    ./clementine.nix
    ./spotify.nix
    ./plexamp.nix
    ./tidal.nix
    ./easyeffects.nix
    ./audacious.nix
    ./playerctl.nix
    ./audacity.nix
  ];

  options.rhodium.home.apps.media.audio = {
    enable = mkEnableOption "Rhodium's audio applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.media.audio = {
      clementine.enable = true;
      spotify.enable = true;
      plexamp.enable = false;
      tidal.enable = false;
      easyeffects.enable = false;
      audacious.enable = false;
      playerctl.enable = false;
      audacity.enable = false;
    };
  };
}
