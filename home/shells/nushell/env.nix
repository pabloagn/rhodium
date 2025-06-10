{ ... }:

{
  programs.nushell = {
    # Environment variables
    environmentVariables = {
      # Core dirs
      RHODIUM = "$HOME/dev/rhodium/rhodium/";
      HOME_PROJECTS = "$HOME/dev/utils/";
      HOME_PROFESSIONAL = "$HOME/professional";
      HOME_ACADEMIC = "$HOME/academic";
      HOME_SOLENOIDLABS = "$HOME/solenoid-labs/";
      HOME_VAULTS = "$HOME/vaults";
      HOME_VAULTS_SANCTUM = "$HOME/vaults/sanctum";
      HOME_DOWNLOADS = "$HOME/downloads/";
      
      # Default applications
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      PAGER = "bat";
      
      # Application settings
      BAT_THEME = "TwoDark";
      FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border --preview 'bat --color=always --style=plain {}'";
      FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
      FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
      FZF_ALT_C_COMMAND = "fd --type d --strip-cwd-prefix --hidden --follow --exclude .git";
      
      # Zoxide
      _ZO_ECHO = "1";
      _ZO_RESOLVE_SYMLINKS = "1";
    };
    
    # Additional environment setup
    extraEnv = ''
      # Set up the prompt
      def create_left_prompt [] {
        let dir = match (do --ignore-errors { $env.PWD | path relative-to $nu.home-path }) {
          null => $env.PWD
          "" => "~"
          $relative_pwd => ([~ $relative_pwd] | path join)
        }
        
        let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
        let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
        let path_segment = $"($path_color)($dir)"
        
        $path_segment
      }
      
      def create_right_prompt [] {
        # Create a right prompt in magenta with the current time
        let time_segment = ([
          (ansi reset)
          (ansi magenta)
          (date now | format date '%x %X')
        ] | str join | str replace --regex --all "([/:])" $"(ansi green)$1(ansi magenta)" )
        
        $time_segment
      }
      
      # Use nushell functions to define the prompt
      $env.PROMPT_COMMAND = {|| create_left_prompt }
      $env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }
      $env.PROMPT_INDICATOR = {|| "> " }
      $env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
      $env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
      $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
      
      # Specifies how environment variables are:
      # - converted from a string to a value on Nushell startup (from_string)
      # - converted from a value back to a string when running external commands (to_string)
      $env.ENV_CONVERSIONS = {
        "PATH": {
          from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
          to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
        "Path": {
          from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
          to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
      }
      
      # Set up PATH
      $env.PATH = ($env.PATH | split row (char esep) | prepend [
        $"($env.HOME)/.local/bin"
        $"($env.HOME)/.cargo/bin"
        $"($env.HOME)/.nix-profile/bin"
        "/run/current-system/sw/bin"
        "/etc/profiles/per-user/($env.USER)/bin"
      ])
      
      # NU_LIB_DIRS for module loading
      $env.NU_LIB_DIRS = [
        ($nu.default-config-dir | path join 'scripts')
        ($nu.data-dir | path join 'completions')
      ]
      
      # NU_PLUGIN_DIRS for plugin loading  
      $env.NU_PLUGIN_DIRS = [
        ($nu.default-config-dir | path join 'plugins')
      ]
    '';
  };
}

