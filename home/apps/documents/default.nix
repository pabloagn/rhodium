# home/apps/documents/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.documents;
in {
  options.rhodium.apps.documents = {
    enable = mkEnableOption "Document processing applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Office suites
      libreoffice
      onlyoffice-bin

      # Document viewers
      okular
      zathura

      # LaTeX
      texmaker
    ];
  };
}
