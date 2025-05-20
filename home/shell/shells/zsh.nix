# home/shell/shells/zsh.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell.shells.zsh;
  aliases = import ../common/aliases.nix;
  functions = import ../common/functions.nix;
in
{
  options.rhodium.shell.shells.zsh = {
    enable = mkEnableOption "Rhodium's ZSH configuration";

    defaultShell = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to set ZSH as the default shell";
    };

    enableSyntaxHighlighting = mkOption {
      type = types.bool;
      default = true;
      description = "Enable ZSH syntax highlighting";
    };

    enableAutosuggestions = mkOption {
      type = types.bool;
      default = true;
      description = "Enable ZSH autosuggestions";
    };

    enableCompletion = mkOption {
      type = types.bool;
      default = true;
      description = "Enable ZSH completion system";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zsh-history-substring-search
    ];

    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = cfg.enableAutosuggestions;
      enableCompletion = cfg.enableCompletion;
      syntaxHighlighting.enable = cfg.enableSyntaxHighlighting;
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true; # Ignore consecutive duplicates
        ignoreAllDups = false; # Don't remove older duplicates
        size = 1000000000; # Very large history size
        save = 1000000000; # Save all entries
        extended = true;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      shellAliases = aliases;

      # ZSH configuration and custom functions
      initExtra = ''
        # Enable vi mode
        bindkey -v

        # Yank to the system clipboard
        function vi-yank-xclip {
          zle vi-yank
          echo "$CUTBUFFER" | wl-copy
        }
        zle -N vi-yank-xclip
        bindkey -M vicmd 'y' vi-yank-xclip

        # Add autocomplete menu options
        zstyle ':completion:*' menu select

        # Bind keys for history substring search
        source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^[OA' history-substring-search-up
        bindkey '^[[A' history-substring-search-up
        bindkey '^[OB' history-substring-search-down
        bindkey '^[[B' history-substring-search-down

        # Change to auto cd (only type the dir)
        setopt autocd

        # Load custom functions
        ${functions.rh}
        ${functions.yy}

        # Load Starship prompt if available
        if command -v starship &> /dev/null; then
          eval "$(starship init zsh)"
        fi
      '';
    };

    programs.eza.enableZshIntegration = cfg.enable;
    programs.direnv.enableZshIntegration = cfg.enable;

    programs.yazi.enableZshIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.yazi.enable;

    programs.ghostty.enableZshIntegration =
      cfg.enable && config.rhodium.apps.terminal.emulators.ghostty.enable;

    programs.wezterm.enableZshIntegration =
      cfg.enable && config.rhodium.apps.terminal.emulators.wezterm.enable;

    programs.kitty.enableZshIntegration =
      cfg.enable && config.rhodium.apps.terminal.emulators.kitty.enable;

    programs.starship.enableZshIntegration =
      cfg.enable && config.rhodium.shell.prompts.starship.enable;

    programs.zoxide.enableZshIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zoxide.enable;

    programs.zellij.enableZshIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zellij.enable;

    programs.atuin.enableZshIntegration =
      cfg.enable && config.rhodium.apps.terminal.utils.zellij.enable;

    home.sessionVariables = mkIf cfg.defaultShell {
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };
}
