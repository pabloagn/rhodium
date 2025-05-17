# home/desktop/notifications/dunst.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.notifications.dunst;
in
{
  home.packages = [ pkgs.dunst ];
}
