# home/development/editors/vscode.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.editors.vscode;
in
{
  options.rhodium.home.development.editors.vscode = {
    enable = mkEnableOption "Rhodium's VSCode configuration";
    variant = mkOption {
      type = types.enum [ "vscode" "vscodium" "insiders" ];
      default = "vscode";
      description = "The variant of VSCode to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      let
        vscodePackage =
          if cfg.variant == "vscode" then pkgs.vscode
          else if cfg.variant == "vscodium" then pkgs.vscodium
          else if cfg.variant == "insiders" then pkgs.vscode-insiders
          else pkgs.vscode;
      in
      [ vscodePackage ];

    xdg.configFile = {
      "vscode/settings.json" = { source = ./vscode/settings.json; };
      "vscode/extensions.json" = { source = ./vscode/extensions.json; };
    };
  };
}
