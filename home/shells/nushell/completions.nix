{ lib, pkgs, ... }:

{
  programs.nushell.extraConfig = ''
    # External completer for getting completions from external sources
    let carapace_completer = {|spans|
      carapace $spans.0 nushell ...$spans | from json
    }
    
    # Fish completer  
    let fish_completer = {|spans|
      ${pkgs.fish}/bin/fish --command $'complete "--do-complete=($spans | str join " ")"'
      | $"($in | lines | parse -r '^(?P<value>[^\t]+)\t?(?P<description>.*)?$')"
      | each { |i| {value: $i.value, description: $i.description} }
    }
    
    # Zoxide completer
    let zoxide_completer = {|spans|
      $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
    }
    
    # Custom completer that combines multiple sources
    let external_completer = {|spans|
      let expanded_alias = scope aliases
        | where name == $spans.0
        | get -i 0.expansion
      
      let spans = if $expanded_alias != null {
        $spans | skip 1 | prepend ($expanded_alias | split row ' ' | take 1)
      } else {
        $spans
      }
      
      # Special handling for certain commands
      match $spans.0 {
        nu => $fish_completer
        git => $fish_completer
        z | zoxide => $zoxide_completer
        _ => $carapace_completer
      } | do $in $spans
    }
    
    # Configure the external completer
    $env.config = ($env.config | merge {
      completions: {
        external: {
          enable: true
          completer: $external_completer
        }
      }
    })
    
    # Git completions
    def "nu-complete git branches" [] {
      ^git branch -a | lines | each { |line| $line | str replace '^\* ' "" | str trim }
    }
    
    def "nu-complete git remotes" [] {
      ^git remote | lines | each { |line| $line | str trim }
    }
    
    # Custom completions for git commands
    export extern "git checkout" [
      branch?: string@"nu-complete git branches"
      --force(-f)
      --quiet(-q)
    ]
    
    export extern "git push" [
      remote?: string@"nu-complete git remotes"
      branch?: string@"nu-complete git branches"
      --force(-f)
      --set-upstream(-u)
      --quiet(-q)
      --verbose(-v)
      --delete(-d)
    ]
    
    # Docker completions
    def "nu-complete docker containers" [] {
      ^docker ps -a --format "{{.Names}}" | lines
    }
    
    def "nu-complete docker images" [] {
      ^docker images --format "{{.Repository}}:{{.Tag}}" | lines | where $it != "<none>:<none>"
    }
    
    export extern "docker run" [
      image: string@"nu-complete docker images"
      --detach(-d)
      --interactive(-i)
      --tty(-t)
      --rm
      --name: string
      --env(-e): string
      --publish(-p): string
      --volume(-v): string
    ]
    
    export extern "docker exec" [
      container: string@"nu-complete docker containers"
      --interactive(-i)
      --tty(-t)
      --env(-e): string
    ]
    
    # Custom path completer
    def "nu-complete dirs" [] {
      ls -la | where type == "dir" | get name
    }
    
    def "nu-complete files" [] {
      ls -la | where type == "file" | get name
    }
  '';
  
  # If carapace is enabled, configure it
  programs.carapace.enableNushellIntegration = lib.mkDefault true;
}
