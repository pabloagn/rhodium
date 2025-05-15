# modules/desktop/apps/default.nix

{ config, pkgs, ... }:

{
  imports = [
    ./browsers
    ./terminal
  ];
}
