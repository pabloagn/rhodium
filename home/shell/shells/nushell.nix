# home/shell/shells/nushell.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell.shells.nushell;
in
{
  options.rhodium.shell.shells.nushell = {
    enable = mkEnableOption "Rhodium's Nushell configuration";
    defaultShell = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to set Nushell as the default shell";
    };
  };

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
    };

    programs.yazi.enableNushellIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.yazi.enable;

    programs.eza.enableNushellIntegration = cfg.enable;
    programs.direnv.enableNushellIntegration = cfg.enable;

    programs.starship.enableNushellIntegration =
      cfg.enable && config.rhodium.shell.prompts.starship.enable;

    programs.zoxide.enableNushellIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zoxide.enable;

    programs.atuin.enableNushellIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.atuin.enable;

    home.sessionVariables = mkIf cfg.defaultShell {
      SHELL = "${pkgs.nushell}/bin/nu";
    };
  };
}
