# home/shell/shells/fish.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell.shells.fish;
in
{
  options.rhodium.shell.shells.fish = {
    enable = mkEnableOption "Rhodium's Fish configuration";
    defaultShell = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to set Fish as the default shell";
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };

    programs.starship.enableFishIntegration =
      cfg.enable && config.rhodium.shell.prompts.starship.enable;

    programs.zoxide.enableFishIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zoxide.enable;

    programs.zellij.enableFishIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.fish.enable;

    programs.atuin.enableFishIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.atuin.enable;

    home.sessionVariables = mkIf cfg.defaultShell {
      SHELL = "${pkgs.fish}/bin/fish";
    };
  };
}
