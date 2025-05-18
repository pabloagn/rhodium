# home/apps/browsers/qutebrowser.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.browsers.qutebrowser;
in
{
  options.rhodium.apps.browsers.qutebrowser = {
    enable = mkEnableOption "Qutebrowser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qutebrowser
    ];
  };
}
