# home/apps/documents/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.documents;
in {
  imports = [
    ./libreoffice.nix
    ./onlyoffice.nix
    ./okular.nix
    ./zathura.nix
    ./texmaker.nix
  ];

  options.rhodium.apps.documents = {
    enable = mkEnableOption "Document processing applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.documents.libreoffice.enable = false;
    rhodium.apps.documents.onlyoffice.enable = true;
    rhodium.apps.documents.okular.enable = true;
    rhodium.apps.documents.zathura.enable = true;
    rhodium.apps.documents.texmaker.enable = true;
  };
}
