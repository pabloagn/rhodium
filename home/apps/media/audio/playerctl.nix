# home/apps/media/audio/playerctl.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.audio.playerctl;
in
{
  options.rhodium.home.apps.media.audio.playerctl = {
    enable = mkEnableOption "Playerctl";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      playerctl
    ];
  };
}
