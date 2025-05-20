# home/desktop/bar/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.bar;
in
{
  imports = [
    ./waybar.nix
  ];

  options.rhodium.home.desktop.bar = {
    enable = mkEnableOption "Rhodium's Desktop Bar";
  };

  config = mkIf cfg.enable {
    rhodium.home.desktop.bar.waybar.enable = true;
  };
}
