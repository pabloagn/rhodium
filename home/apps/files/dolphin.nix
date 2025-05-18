# home/apps/files/dolphin.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.files.dolphin;
in
{
  options.rhodium.apps.files.dolphin = {
    enable = mkEnableOption "Dolphin file manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dolphin
    ];
  };
}
