# home/apps/documents/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.documents;
in {
  imports = [
    ./libreoffice.nix
    ./onlyoffice.nix
    ./okular.nix
    ./zathura.nix
    ./texmaker.nix
  ];

  options.rhodium.home.apps.documents = {
    enable = mkEnableOption "Document processing applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.documents.libreoffice.enable = false;
    rhodium.home.apps.documents.onlyoffice.enable = true;
    rhodium.home.apps.documents.okular.enable = true;
    rhodium.home.apps.documents.zathura.enable = true;
    rhodium.home.apps.documents.texmaker.enable = true;
  };
}
