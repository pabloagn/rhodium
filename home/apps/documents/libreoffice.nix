# home/apps/documents/libreoffice.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.documents.libreoffice;
in
{
  options.rhodium.apps.documents.libreoffice = {
    enable = mkEnableOption "LibreOffice";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
