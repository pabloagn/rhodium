# home/desktop/launchers/rofi.nix

{ lib, config, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.launchers.rofi;
  parentCfg = config.rhodium.home.desktop.launchers;
in
{
  options.rhodium.home.desktop.launchers.rofi = {
    enable = mkEnableOption "Rhodium's Rofi Launcher" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      # font = "Iosevka Nerd Font 10";
      font = "JetBrainsMono Nerd Font 11";
      theme = ./rofi/themes/phantom.rasi;
    };
  };
}
