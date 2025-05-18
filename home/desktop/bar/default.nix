# home/desktop/bar/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.bar;
in
{
  imports = [
    ./waybar.nix
  ];

  options.rhodium.desktop.bar = {
    enable = mkEnableOption "Rhodium's Desktop Bar";
  };

  config = mkIf cfg.enable {
    rhodium.desktop.bar.waybar.enable = true;
  };
}
