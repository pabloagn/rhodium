# home/apps/files/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.files;
in {
  options.rhodium.apps.files = {
    enable = mkEnableOption "File management applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # File managers
      pcmanfm
      thunar
      nautilus
    ];
  };
}
