# home/development/editors/vscode.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.vscode;
in
{
  options.rhodium.development.editors.vscode = {
    enable = mkEnableOption "Rhodium's VSCode configuration";
  };

  config = mkIf (config.rhodium.development.editors.enable && cfg.enable) {
    home.packages = with pkgs; [
      vscode
    ];

    # Configuration - keeping your existing structure
    xdg.configFile = {
      "vscode/settings.json" = { source = ./vscode/settings.json; };
    };
  };
}
