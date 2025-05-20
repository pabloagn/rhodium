# home/apps/media/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media;
in
{
  imports = [
    ./audio
    ./image
    ./video
  ];

  options.rhodium.home.apps.media = {
    enable = mkEnableOption "Media applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.media = {
      audio.enable = true;
      image.enable = true;
      video.enable = true;
    };
  };
}
