# home/apps/documents/libreoffice.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.documents.libreoffice;
in
{
  options.rhodium.home.apps.documents.libreoffice = {
    enable = mkEnableOption "LibreOffice";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
