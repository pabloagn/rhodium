# home/apps/media/audio/tidal.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.audio.tidal;
in
{
  options.rhodium.home.apps.media.audio.tidal = {
    enable = mkEnableOption "Rhodium's tidal client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tidal-hifi
      tidal-dl
    ];
  };
}
