# home/apps/documents/onlyoffice.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.documents.onlyoffice;
in
{
  options.rhodium.apps.documents.onlyoffice = {
    enable = mkEnableOption "OnlyOffice";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      onlyoffice-bin
    ];
  };
}
