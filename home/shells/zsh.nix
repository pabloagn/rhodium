{ config, pkgs, ... }:

let
  common = import ./common { inherit config; };
  functions = common.functions;
in
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion = {
      enable = true;
      # TODO: Add styles here
      # highlight = {};
    };
    enableCompletion = true;
    autocd = true;

    syntaxHighlighting = {
      # TODO: Add styles here
      enable = true;
      # styles = {
      #   "alias" = "fg=bold";
      # };
    };

    shellAliases = common.aliases;
    # TODO:
    #   - See if this is actually correct.
    #   - Annoyed as fuck that the history disappears at times.
    history = {
      extended = true; # Save timestamps (TODO: this is causing a fucking issue on nix shells (commands are pulled along with their timestamps))
      expireDuplicatesFirst = true;
      ignoreDups = true; # Ignore consecutive duplicates
      ignoreAllDups = false; # Don't remove older duplicates
      save = 1000000000; # Save all entries
      size = 1000000000; # Very large history size
      path = "${config.xdg.cacheHome}/zsh/.zsh_history";
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = "^[[A";
      searchDownKey = "^[[B";
    };

    initContent = ''
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
      # Include hidden files
      #_comp_options += (globdots)

      # Include custom functions
      ${functions.yy}
      ${functions.rh}
    '';
  };
}
