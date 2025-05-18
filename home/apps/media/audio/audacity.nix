# home/apps/media/audio/audacity.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.audio.audacity;
in
{
  options.rhodium.apps.media.audio.audacity = {
    enable = mkEnableOption "Audacity";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
