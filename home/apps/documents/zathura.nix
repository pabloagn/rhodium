# home/apps/documents/zathura.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.documents.zathura;
in
{
  options.rhodium.home.apps.documents.zathura = {
    enable = mkEnableOption "Zathura";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zathura
    ];
  };
}
