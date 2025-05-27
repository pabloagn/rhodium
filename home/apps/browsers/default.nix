{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./firefox.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    brave
    w3m
    librewolf
    tor-browser-bundle-bin
    qutebrowser
  ];
}
