# home/apps/media/audio/easyeffects.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.audio.easyeffects;
in
{
  options.rhodium.home.apps.media.audio.easyeffects = {
    enable = mkEnableOption "EasyEffects";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      easyeffects
    ];
  };
}
