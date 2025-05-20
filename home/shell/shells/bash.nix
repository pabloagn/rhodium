# home/shell/shells/bash.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell.shells.bash;
  aliases = import ../common/aliases.nix;
  functions = import ../common/functions.nix;
in
{
  options.rhodium.shell.shells.bash = {
    enable = mkEnableOption "Rhodium's Bash configuration";
    defaultShell = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to set Bash as the default shell";
    };
    enableCompletion = mkOption {
      type = types.bool;
      default = true;
      description = "Enable tab completion system";
    };
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;

      # History configuration
      historyControl = [
        "erasedups"
        "ignoredups"
        "ignorespace"
      ];

      historyFileSize = 10000;
      historySize = 10000;

      # Use the same aliases as in ZSH
      shellAliases = aliases;

      # Bash configuration
      bashrcExtra = ''
        # Basic Bash configuration
        export HISTTIMEFORMAT="%F %T "

        # Better history search with arrow keys
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'

        # Enable vi mode (similar to ZSH setup)
        set -o vi

        # Load custom functions
        ${functions.rh}

        # Load Starship prompt if available
        if command -v starship &> /dev/null; then
          eval "$(starship init bash)"
        fi
      '';

      enableCompletion = cfg.enableCompletion;
    };

    programs.starship.enableBashIntegration =
      cfg.enable && config.rhodium.shell.prompts.starship.enable;

    programs.zoxide.enableBashIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zoxide.enable;

    programs.zellij.enableBashIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zellij.enable;

    programs.atuin.enableBashIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.atuin.enable;

    home.sessionVariables = mkIf cfg.defaultShell {
      SHELL = "${pkgs.bash}/bin/bash";
    };
  };
}
