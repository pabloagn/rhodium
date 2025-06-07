{ ... }:

{
  zshFunctions = {
    # Special yazi
    yy = ''
      function yy() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';
  };

  fishFunctions = {
    # Special yazi
    yy = ''
      function yy
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
          cd -- "$cwd"
        end
        rm -f -- "$tmp"
      end
    '';
    
    # Jumpers
    jtf = ''
      function jtf --description "Jump To File: Fuzzy file finder with preview"
        fd -t f --strip-cwd-prefix | fzf --preview 'bat --color=always --style=plain {}' | xargs -r $EDITOR
      end
    '';
  
    jtd = ''
      function jtd --description "Jump To Dir: Fuzzy dir finder with preview"
        fd -t d --strip-cwd-prefix | fzf --preview 'eza --tree --level=4 --color=always {}' | xargs -r z
      end
    '';
    
    jtp = ''
      function jtp --description "Jump To Proj: Quick project switcher"
        set -l project_dirs $HOME_PROJECTS $HOME_PROFESSIONAL $HOME_SOLENOIDLABS $RHODIUM
        set -l project (fd . $project_dirs -d 1 --type d 2>/dev/null | fzf --preview 'eza --tree --level=2 --color=always {}')
        if test -n "$project"
          cd "$project"
        end
      end
    '';

    xrt = ''
      function xrt --description "Extract archives"
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
    
    mkz = ''
      function mkz --description "Create directory and cd into it"
        mkdir -p $argv[1] && cd $argv[1]
      end
    '';
    
    bkp = ''
      function bkp --description "Create backup of file"
        cp $argv[1] $argv[1].bak.(date +%Y%m%d-%H%M%S)
      end
    '';
    
    __direnv_export_eval = ''
      function __direnv_export_eval --on-event fish_prompt
        begin
          begin
            direnv export fish
          end 1>| source
        end 2>| egrep -v -e "^direnv: (export|loading|using|nix-direnv:)" -e "Welcome to"
      end
    '';
  };
}
