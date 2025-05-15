# modules/desktop/apps/browsers/firefox.nix

{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
  };
}
