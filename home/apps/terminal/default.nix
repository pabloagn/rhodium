# home/apps/terminal/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminal;
in
{
  imports = [
    ./emulators
    ./utils
  ];
}
