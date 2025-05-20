# home/apps/media/image/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.media.image;
in
{
  options.rhodium.home.apps.media.image = {
    enable = mkEnableOption "Image applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Image viewers
      feh # TODO: This must not be here. It's used throughout the system.
      sxiv

      # Image editors and manipulation
      imagemagick
      inkscape
      figma-linux
      blender
      exiv2 # Image metadata manipulation
    ];
  };
}
