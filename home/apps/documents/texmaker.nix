# home/apps/documents/texmaker.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.documents.texmaker;
in
{
  options.rhodium.apps.documents.texmaker = {
    enable = mkEnableOption "Texmaker";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      texmaker
    ];
  };
}
