# home/apps/browsers/default.nix
# DONE

{ config, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.browsers;
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

  options.rhodium.home.apps.browsers = {
    enable = mkEnableOption "Rhodium's Web browsers";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.browsers = {
      firefox.enable = false;
      zen.enable = false;
      brave.enable = false;
      librewolf.enable = false;
      chromium.enable = false;
      tor.enable = false;
      qutebrowser.enable = false;
      w3m.enable = false;
    };
  };
}
