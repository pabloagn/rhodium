{ ... }:

{
  programs.fish = {
    functions = {
      vw = {
        description = "Neovim with automatic fullscreen padding";
        body = ''
          # Remove padding when entering
          kitty @ set-spacing padding=0
          # Run nvim with all arguments
          command nvim $argv
          # Capture the exit status
          set -l exit_status $status
          # Restore padding when exiting
          kitty @ set-spacing padding=10 padding=15 padding=15 padding=15
          # Return the original exit status
          return $exit_status
        '';
      };

      yw = {
        description = "Yazi with automatic fullscreen padding";
        body = ''
          # Remove padding when entering
          kitty @ set-spacing padding=0

          # Your existing yazi logic with cwd handling
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          command yazi $argv --cwd-file="$tmp"

          # Capture exit status before any other commands
          set -l exit_status $status

          # Handle directory change
          if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"

          # Restore padding when exiting
          kitty @ set-spacing padding=10 padding=15 padding=15 padding=15

          # Return the original exit status
          return $exit_status
        '';
      };

      jtf = {
        description = "Jump To File: Fuzzy file finder with preview";
        body = ''
          set -l file (fd -t f --strip-cwd-prefix | fzf --preview 'bat --color=always --style=plain {}')
          if test -n "$file"
            $EDITOR "$file"
          end
          complete -c jtf -f
        '';
      };

      jtd = {
        description = "Jump To Dir: Fuzzy dir finder with preview";
        body = ''
          set -l dir (fd -t d --strip-cwd-prefix | fzf --preview 'eza --tree --level=4 --color=always {}')
          if test -n "$dir"
            cd "$dir"
          end
          complete -c jtd -f
        '';
      };

      jtp = {
        description = "Jump To Proj: Quick project switcher";
        body = ''
          set -l project_dirs $HOME_PROJECTS $HOME_PROFESSIONAL $HOME_SOLENOIDLABS $RHODIUM
          set -l project (fd . $project_dirs -d 1 --type d 2>/dev/null | fzf --preview 'eza --tree --level=2 --color=always {}')
          if test -n "$project"
            cd "$project"
          end
          complete -c jtp -f
        '';
      };

      xrt = {
        description = "Extract archives";
        body = ''
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
          complete -c xrt -f
        '';
      };

      mkz = {
        description = "Create directory and cd into it";
        body = ''
          mkdir -p $argv[1] && cd $argv[1]
          complete -c mkz -f
        '';
      };

      bkp = {
        description = "Create backup of file";
        body = ''
          cp $argv[1] $argv[1].bak.(date +%Y%m%d-%H%M%S)
          complete -c bkp -f
        '';
      };

      __direnv_export_eval = {
        onEvent = "fish_prompt";
        body = ''
          begin
            begin
              direnv export fish
            end 1>| source
          end 2>| egrep -v -e "^direnv: (export|loading|using|nix-direnv:)" -e "Welcome to"
        '';
      };
    };
  };
}
