# home/apps/media/audio/plexamp.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.audio.plexamp;
in
{
  options.rhodium.apps.media.audio.plexamp = {
    enable = mkEnableOption "Rhodium's plexamp client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      plexamp
    ];
  };
}
