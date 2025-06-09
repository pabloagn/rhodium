{ ... }:

{
  programs.nushell.extraConfig = ''
    # Yazi wrapper for changing directory on exit
    def --env yy [...args] {
      let tmp = (mktemp -t "yazi-cwd.XXXXXX")
      run-external yazi ...$args --cwd-file $tmp
      let cwd = (open $tmp | str trim)
      
      if ($cwd | is-not-empty) and ($cwd != $env.PWD) {
        cd $cwd
      }
      
      rm -f $tmp
    }
    
    # Jump to file - fuzzy file finder with preview
    def jtf [] {
      let file = (
        fd -t f --strip-cwd-prefix 
        | fzf --preview 'bat --color=always --style=plain {}' 
        | str trim
      )
      
      if ($file | is-not-empty) {
        ^$env.EDITOR $file
      }
    }
    
    # Jump to directory - fuzzy dir finder with preview
    def --env jtd [] {
      let dir = (
        fd -t d --strip-cwd-prefix 
        | fzf --preview 'eza --tree --level=4 --color=always {}' 
        | str trim
      )
      
      if ($dir | is-not-empty) {
        cd $dir
      }
    }
    
    # Jump to project - quick project switcher
    def --env jtp [] {
      let project_dirs = [
        $env.HOME_PROJECTS
        $env.HOME_PROFESSIONAL  
        $env.HOME_SOLENOIDLABS
        $env.RHODIUM
      ]
      
      let project = (
        fd . ...$project_dirs -d 1 --type d 
        | complete 
        | get stdout 
        | fzf --preview 'eza --tree --level=2 --color=always {}' 
        | str trim
      )
      
      if ($project | is-not-empty) {
        cd $project
      }
    }
    
    # Extract archives
    def xrt [...files] {
      for file in $files {
        if ($file | path exists) {
          match ($file | path parse | get extension) {
            "tar.bz2" | "tbz2" => { tar xjf $file }
            "tar.gz" | "tgz" => { tar xzf $file }
            "bz2" => { bunzip2 $file }
            "gz" => { gunzip $file }
            "tar" => { tar xf $file }
            "zip" => { unzip $file }
            "7z" => { 7z x $file }
            _ => { print $"Unknown archive format: ($file)" }
          }
        } else {
          print $"($file) is not a valid file"
        }
      }
    }
    
    # Create directory and cd into it
    def --env mkz [dir: path] {
      mkdir -p $dir
      cd $dir
    }
    
    # Create backup of file with timestamp
    def bkp [file: path] {
      let timestamp = (date now | format date "%Y%m%d-%H%M%S")
      cp $file $"($file).bak.($timestamp)"
    }
    
    # FZF history widget
    def --env fzf-history-widget [] {
      let cmd = (
        history 
        | get command 
        | reverse 
        | uniq 
        | str join (char nl) 
        | fzf --height 40% --reverse 
        | str trim
      )
      
      if ($cmd | is-not-empty) {
        commandline edit --replace $cmd
      }
    }
    
    # Interactive directory navigation with zoxide
    def --env zi [...args] {
      let result = (zoxide query -i ...$args | str trim)
      if ($result | is-not-empty) {
        cd $result
      }
    }
    
    # Previous command with sudo
    def --env "!!" [] {
      let last_cmd = (history | last | get command)
      sudo $last_cmd
    }
    
    # Quick file preview
    def preview [file: path] {
      if ($file | path exists) {
        match ($file | path parse | get extension) {
          "md" => { glow $file }
          "pdf" => { pdftotext $file - | bat }
          "jpg" | "jpeg" | "png" | "gif" => { chafa $file }
          _ => { bat $file }
        }
      }
    }
    
    # Git status with file preview
    def gsp [] {
      let file = (
        git status --short 
        | lines 
        | each { |line| $line | str substring 3.. } 
        | fzf --preview 'bat --color=always {}' 
        | str trim
      )
      
      if ($file | is-not-empty) {
        ^$env.EDITOR $file
      }
    }
  '';
}
