# home/apps/documents/zathura.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.documents.zathura;
in
{
  options.rhodium.apps.documents.zathura = {
    enable = mkEnableOption "Zathura";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zathura
    ];
  };
}
