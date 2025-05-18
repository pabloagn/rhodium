# home/apps/browsers/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.browsers;
in
{
  imports = [
    ./firefox.nix
    ./zen.nix
    ./brave.nix
    ./librewolf.nix
    ./chromium.nix
    ./tor.nix
    ./qutebrowser.nix
    ./w3m.nix
  ];

  options.rhodium.apps.browsers = {
    enable = mkEnableOption "Rhodium's Web browsers";
  };

  config = mkIf cfg.enable {
    rhodium.apps.browsers.brave.enable = true;
    rhodium.apps.browsers.librewolf.enable = false;
    rhodium.apps.browsers.tor.enable = false;
    rhodium.apps.browsers.qutebrowser.enable = false;
    rhodium.apps.browsers.chromium.enable = false;
    rhodium.apps.browsers.w3m.enable = false;
    rhodium.apps.browsers.firefox = {
      enable = true;
      variant = "stable";
    };
    rhodium.apps.browsers.zen = {
      enable = true;
      variant = "specific";
    };
  };
}
