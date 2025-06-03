{ config, pkgs, ... }:

let
  common = import ../common { inherit config pkgs; };
in
{
  # Yazi integration
  yy = common.functions.fishFunctions.yy;

  # Quick project switcher that actually works
  p = ''
    function p --description "Quick project switcher"
      set -l project_dirs ~/projects ~/rhodium ~/work
      set -l project (fd . $project_dirs -d 1 --type d 2>/dev/null | fzf --preview 'eza --tree --level=2 --color=always {}')
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

  # Quick mkdir and cd
  mkcd = ''
    function mkcd --description "Create directory and cd into it"
      mkdir -p $argv[1] && cd $argv[1]
    end
  '';

  # Backup file
  backup = ''
    function backup --description "Create backup of file"
      cp $argv[1] $argv[1].bak.(date +%Y%m%d-%H%M%S)
    end
  '';
}
