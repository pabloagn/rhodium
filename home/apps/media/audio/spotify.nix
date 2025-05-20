# home/apps/media/audio/spotify.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.audio.spotify;
in
{
  options.rhodium.home.apps.media.audio.spotify = {
    enable = mkEnableOption "Rhodium's spotify client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
