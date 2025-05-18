# home/apps/browsers/brave.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.browsers.brave;
in
{
  options.rhodium.apps.browsers.brave = {
    enable = mkEnableOption "Brave Browser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
