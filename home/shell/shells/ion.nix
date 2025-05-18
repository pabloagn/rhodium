# home/shell/shells/ion.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell.shells.ion;
in
{
  options.rhodium.shell.shells.ion = {
    enable = mkEnableOption "Rhodium's Ion configuration";
    defaultShell = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to set Ion as the default shell";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ion
    ];

    programs.starship.enableIonIntegration =
      cfg.enable && config.rhodium.shell.prompts.starship.enable;

    programs.zoxide.enableIonIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zoxide.enable;

    home.sessionVariables = mkIf cfg.defaultShell {
      SHELL = "${pkgs.ion}/bin/ion";
    };
  };
}
