# home/apps/files/nautilus.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.files.nautilus;
in
{
  options.rhodium.home.apps.files.nautilus = {
    enable = mkEnableOption "Nautilus file manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}
