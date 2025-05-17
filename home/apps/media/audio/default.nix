# home/apps/media/audio/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.audio;
in {
  options.rhodium.apps.media.audio = {
    enable = mkEnableOption "Audio applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Audio players
      audacious
      spotify
      plexamp
      tidal-hifi
      playerctl

      # Audio editors
      audacity

      # Audio utilities
      easyeffects
    ];
  };
}
