# assets/fonts/default.nix
{ config, lib, pkgs, ... }:

{
  fonts.packages = [
    (pkgs.callPackage ../../overlays/custom-font.nix {})
  ];

  # Copy company brand assets to the correct location
  home.file.".local/share/company/branding" = {
    source = ../../../assets/images/branding;
    recursive = true;
  };
}
