# home/apps/media/audio/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.audio;
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

  options.rhodium.apps.media.audio = {
    enable = mkEnableOption "Rhodium's audio applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.media.audio.clementine.enable = false;
    rhodium.apps.media.audio.spotify.enable = false;
    rhodium.apps.media.audio.plexamp.enable = false;
    rhodium.apps.media.audio.tidal.enable = false;
    rhodium.apps.media.audio.easyeffects.enable = false;
    rhodium.apps.media.audio.audacious.enable = false;
    rhodium.apps.media.audio.playerctl.enable = false;
    rhodium.apps.media.audio.audacity.enable = false;
  };
}
