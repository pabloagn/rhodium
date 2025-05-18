# home/apps/files/nautilus.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.files.nautilus;
in
{
  options.rhodium.apps.files.nautilus = {
    enable = mkEnableOption "Nautilus file manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}
