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
      set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
      set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border=sharp \
        --preview-window=right:60%:wrap \
        --bind='ctrl-/:toggle-preview' \
        --bind='ctrl-u:preview-half-page-up' \
        --bind='ctrl-d:preview-half-page-down' \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

      # File preview for FZF
      set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
      set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --level=2 --color=always {}'"

      # Skim as alternative fuzzy finder (Ctrl+R for history will use this)
      set -gx SKIM_DEFAULT_OPTIONS "--height 50% --layout=reverse --preview-window=right:50%"

      # Better defaults
      set -g fish_greeting
      set -g fish_cursor_default block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace_one underscore
      set -g fish_vi_force_cursor 1

      # History settings
      set -g history_max 1000000
    '';

    interactiveShellInit = ''
      # Auto CD
      # set -U fish_features qmark-noglob regex-easyesc ampersand-nobg-in-token stderr-nocaret

      # Smart history - Atuin for main history, mcfly for quick access
      set -gx ATUIN_NOBIND true  # We'll set custom bindings
      atuin init fish --disable-up-arrow | source

      # Keybindings
      bind \cr '_atuin_search'  # Ctrl+R for atuin
      bind -M insert \cr '_atuin_search'
      bind \cs '__mcfly_search'  # Ctrl+S for mcfly as alternative
      bind -M insert \cs '__mcfly_search'
      bind \cf '__fzf_find_file'  # Ctrl+F to find files
      bind -M insert \cf '__fzf_find_file'
      bind \eg '__fzf_cd'  # Alt+G to cd with fzf
      bind -M insert \eg '__fzf_cd'

      # Smart directory navigation
      bind \eh 'prevd; commandline -f repaint'  # Alt+H previous dir
      bind \el 'nextd; commandline -f repaint'  # Alt+L next dir

      # FZF integration
      fzf --fish | source

      # Directory tracking for better cd experience
      function __update_cwd_osc --on-variable PWD
        printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
      end

      # Auto-suggestions style
      set -g fish_color_autosuggestion 555 brblack
      set -g fish_color_command green
      set -g fish_color_error red
      set -g fish_color_param cyan
      set -g fish_color_quote yellow

      # Abbreviations for common commands (smarter than aliases)
      abbr -a g git
      abbr -a ga 'git add'
      abbr -a gc 'git commit'
      abbr -a gco 'git checkout'
      abbr -a gd 'git diff'
      abbr -a gl 'git log --oneline --graph'
      abbr -a gs 'git status'
      abbr -a l 'eza -la'
      abbr -a ll 'eza -la --tree --level=2'
      abbr -a ... 'cd ../..'
      abbr -a .... 'cd ../../..'

      # Smart command not found handler with auto-cd
      function fish_command_not_found
        if test -d $argv[1]
          cd $argv[1]
          eza -la
        else
          __fish_default_command_not_found_handler $argv
        end
      end


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
      # Yazi integration
      yy = common.functions.fishFunctions.yy;

      # Enhanced mcfly search
      __mcfly_search = ''
        function __mcfly_search
          set -l cmd (mcfly search (commandline))
          if test -n "$cmd"
            commandline -r "$cmd"
          end
          commandline -f repaint
        end
      '';

      # FZF file finder
      __fzf_find_file = ''
        function __fzf_find_file
          set -l file (fd --type f --hidden --follow --exclude .git | fzf)
          if test -n "$file"
            commandline -i "$file"
          end
          commandline -f repaint
        end
      '';

      # FZF directory navigation
      __fzf_cd = ''
        function __fzf_cd
          set -l dir (fd --type d --hidden --follow --exclude .git | fzf)
          if test -n "$dir"
            cd "$dir"
            eza -la
          end
          commandline -f repaint
        end
      '';

      # Quick project switcher
      p = ''
        function p --description "Quick project switcher"
          set -l project_dirs ~/projects ~/rhodium ~/work
          set -l project (fd . $project_dirs -d 1 --type d | sk --preview 'eza --tree --level=2 --color=always {}')
          if test -n "$project"
            cd "$project"
          end
        end
      '';

      # Smart extract function
      extract = ''
        function extract --description "Extract archives"
          for file in $argv
            if test -f $file
              switch $file
                case '*.tar.bz2'
                  tar xjf $file
                case '*.tar.gz'
                  tar xzf $file
                case '*.bz2'
                  bunzip2 $file
                case '*.gz'
                  gunzip $file
                case '*.tar'
                  tar xf $file
                case '*.tbz2'
                  tar xjf $file
                case '*.tgz'
                  tar xzf $file
                case '*.zip'
                  unzip $file
                case '*.7z'
                  7z x $file
                case '*'
                  echo "Unknown archive format: $file"
              end
            else
              echo "$file is not a valid file"
            end
          end
        end
      '';

      # Improved directory listing on cd
      # cd = ''
      #   function cd --description "Change directory and list contents"
      #     builtin cd $argv
      #     and eza -la --group-directories-first
      #   end
      # '';
    };
  };
}
