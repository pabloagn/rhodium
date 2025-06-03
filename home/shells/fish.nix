{ config, pkgs, ... }:

let
  common = import ./common { inherit config pkgs; };
in
{
  programs.man.generateCaches = false;
  programs.fish = {
    enable = true;
    shellAliases = common.aliases;
    shellInit = ''
      # Set vi key bindings
      fish_vi_key_bindings

      # FZF integration
      set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
      set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:wrap"

      # Better defaults
      set -g fish_greeting # Disable greeting
      set -gx EDITOR nvim
      set -gx VISUAL nvim

      # History settings
      set -g history_max 1000000
    '';

    interactiveShellInit = ''
      # Auto CD
      set -U fish_features qmark-noglob regex-easyesc ampersand-nobg-in-token stderr-nocaret

      # Atuin keybinding
      bind \ce _atuin_search
      bind -M insert \ce _atuin_search

      # FZF keybindings
      fzf --fish | source

      # Custom prompt - clean and minimal
      function fish_prompt
          set -l last_status $status
          set -l cwd (prompt_pwd)

          if test $last_status -eq 0
              set_color green
              echo -n "➜ "
          else
              set_color red
              echo -n "➜ "
          end

          set_color blue
          echo -n $cwd
          set_color normal
          echo -n " "
      end

      # Right prompt for git
      function fish_right_prompt
          set_color brblack
          echo -n (date +%H:%M)
          set_color normal
      end
    '';

    functions = {
      yy = common.functions.fishfunctions.yy;
    };
  };
}
