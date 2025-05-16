# home/desktop/launcher/fuzzel.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.launcher.fuzzel;
in
{
  options.rhodium.desktop.launcher.fuzzel = {
    enable = mkEnableOption "Rhodium's Fuzzel configuration";
  };

  config = mkIf cfg.enable {
    # Keep your existing configuration
    xdg.configFile."fuzzel/fuzzel.ini" = {
      # Keeping the direct source approach as you had it
      # Will need to adjust the path if your config file moves
      source = ./fuzzel/fuzzel.ini;
    };
  };
}
