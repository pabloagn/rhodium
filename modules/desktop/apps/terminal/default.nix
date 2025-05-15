# modules/desktop/apps/terminal/default.nix

{ config, pkgs, ... }:

{
  imports = [
    ./kitty
    ./ghostty
  ];
}
