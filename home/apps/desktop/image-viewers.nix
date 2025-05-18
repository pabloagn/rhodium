# home/apps/desktop/image-viewers.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.desktop.imageViewers;
  defs = import ../../lib/desktop-definitions.nix { inherit lib config pkgs; };
in
{
  options.rhodium.apps.desktop.imageViewers = {
    enable = mkEnableOption "Desktop Image Viewer Applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [

      # Feh Image Viewer
      (makeDesktopItem {
        name = "feh-image-viewer";
        desktopName = "Feh Image Viewer";
        genericName = defs.genericStrings.name.appImageViewer;
        exec = "${pkgs.feh}/bin/feh -Z --scale-down --auto-zoom --image-bg black %f";
        icon = defs.logos.feh;
        comment = "View images with feh in full-screen mode with black background";
        categories = [ "Graphics" "Viewer" ];
        mimeTypes = [
          "image/bmp"
          "image/gif"
          "image/jpeg"
          "image/jpg"
          "image/pjpeg"
          "image/png"
          "image/tiff"
          "image/webp"
          "image/x-bmp"
          "image/x-pcx"
          "image/x-png"
          "image/x-portable-anymap"
          "image/x-portable-bitmap"
          "image/x-portable-graymap"
          "image/x-portable-pixmap"
          "image/x-tga"
          "image/x-xbitmap"
          "image/svg+xml"
        ];
      })
    ];
  };
}
