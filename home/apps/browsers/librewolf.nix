# home/apps/browsers/librewolf.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.browsers.librewolf;
in
{
  options.rhodium.home.apps.browsers.librewolf = {
    enable = mkEnableOption "Librewolf Browser";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
    };
  };
}
