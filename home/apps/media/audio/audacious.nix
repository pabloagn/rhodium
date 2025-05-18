# home/apps/media/audio/audacious.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.audio.audacious;
in
{
  options.rhodium.apps.media.audio.audacious = {
    enable = mkEnableOption "Audacious";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      audacious
    ];
  };
}
