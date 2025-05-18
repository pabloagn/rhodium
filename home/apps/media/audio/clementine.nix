# home/apps/media/audio/clementine.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media.audio.clementine;
in
{
  options.rhodium.apps.media.audio.clementine = {
    enable = mkEnableOption "Rhodium's clementine client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clementine
    ];
  };
}
