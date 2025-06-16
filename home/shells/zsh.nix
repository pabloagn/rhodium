{config, ...}: let
  aliases = import ./common/aliases.nix {};
  functions = import ./common/functions.nix {};
in {
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;

      # Customize suggestion appearance
      highlight = "fg=#7d7d7d,underline";
      strategy = [
        "history"
        "completion"
        "match_prev_cmd"
      ];
    };

    enableCompletion = true;
    autocd = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "cursor"
        "regexp"
        "root"
        "line"
      ];
      styles = {
        "command" = "fg=green,bold";
        "alias" = "fg=blue,bold";
        "builtin" = "fg=cyan,bold";
        "function" = "fg=magenta,bold";
        "command-substitution-delimiter" = "fg=yellow";
        "single-hyphen-option" = "fg=cyan";
        "double-hyphen-option" = "fg=cyan";
      };
    };

    shellAliases = aliases;

    history = {
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = false; # Keep duplicates for better context
      ignoreAllDups = false;
      ignoreSpace = true; # Commands starting with space won't be saved
      save = 1000000000;
      size = 1000000000;
      path = "${config.xdg.cacheHome}/zsh/.zsh_history";
      share = true; # Share between sessions
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
    '';
  };
}
