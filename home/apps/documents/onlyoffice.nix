# home/apps/documents/onlyoffice.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.documents.onlyoffice;
in
{
  options.rhodium.home.apps.documents.onlyoffice = {
    enable = mkEnableOption "OnlyOffice";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      onlyoffice-bin
    ];
  };
}
