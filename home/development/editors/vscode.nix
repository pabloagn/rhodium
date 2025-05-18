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

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      # package = pkgs.vscodium;
    };

    xdg.configFile = {
      "vscode/settings.json" = { source = ./vscode/settings.json; };
      "vscode/extensions.json" = { source = ./vscode/extensions.json; };
      # "vscode/keybindings.json" = { source = ./vscode/keybindings.json; };
      # "vscode/snippets" = { source = ./vscode/snippets; recursive = true; };
    };
  };
}
