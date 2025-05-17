# home/development/editors/vscodium.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.vscodium;
in
{
  options.rhodium.development.editors.vscodium = {
    enable = mkEnableOption "Rhodium's VSCodium configuration";
  };

  config = mkIf (config.rhodium.development.editors.enable && cfg.enable) {
    home.packages = with pkgs; [
      vscodium
    ];

    # Configuration - keeping your existing structure
    xdg.configFile = {
      "vscodium/settings.json" = { source = ./vscode/settings.json; };
    };
  };
}
