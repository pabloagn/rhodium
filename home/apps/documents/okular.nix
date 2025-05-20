# home/apps/documents/okular.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.documents.okular;
in
{
  options.rhodium.home.apps.documents.okular = {
    enable = mkEnableOption "Okular";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.okular
    ];
  };
}
