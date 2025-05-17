# home/apps/media/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.media;
in {
  imports = [
    ./audio
    ./video
    ./image
  ];

  options.rhodium.apps.media = {
    enable = mkEnableOption "Media applications";
  };

  config = mkIf cfg.enable {
  };
}
