# home/apps/media/audio/audacity.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.audio.audacity;
in
{
  options.rhodium.home.apps.media.audio.audacity = {
    enable = mkEnableOption "Audacity";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
