# home/apps/media/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media;
in
{
  imports = [
    ./audio
    ./image
    ./video
  ];

  options.rhodium.apps.media = {
    enable = mkEnableOption "Media applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.media.audio.enable = true;
    rhodium.apps.media.image.enable = true;
    rhodium.apps.media.video.enable = true;
  };
}
