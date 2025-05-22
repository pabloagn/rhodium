# home/development/editors/lapce.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.editors.lapce;
in
{
  options.rhodium.home.development.editors.lapce = {
    enable = mkEnableOption "Rhodium's Lapce configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lapce
    ];
  };
}
