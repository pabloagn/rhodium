# home/apps/browsers/qutebrowser.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.browsers.qutebrowser;
in
{
  options.rhodium.home.apps.browsers.qutebrowser = {
    enable = mkEnableOption "Qutebrowser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qutebrowser
    ];
  };
}
