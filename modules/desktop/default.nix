# modules/desktop/default.nix

{ config, lib, pkgs, ... }:

{
  imports = [
    ./wm
    ./apps
  ];
}
