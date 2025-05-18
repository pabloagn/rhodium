# home/apps/documents/okular.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.documents.okular;
in
{
  options.rhodium.apps.documents.okular = {
    enable = mkEnableOption "Okular";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.okular
    ];
  };
}
