# home/environment/variables.nix

{ lib, config, pkgs, self, ... }:

with lib;
let
  cfg = config.rhodium.environment.variables;

  # Import the path helper
  rhodiumPaths = import ../lib/paths.nix {
    inherit lib config;
    flakeRoot = self;
  };

  # Get generated environment variables from the paths
  pathVariables = rhodiumPaths.mkSessionVariables;

  # Get clean path references
  paths = rhodiumPaths.paths;
in
{
  options.rhodium.environment.variables = {
    enable = mkEnableOption "Rhodium's environment variables";
  };

  config = mkIf cfg.enable {
    # System paths from our path module
    home.sessionVariables = pathVariables // {

      # Rhodium
      RHODIUM = "${paths.home}/rhodium";

      # Default applications
      BROWSER = "firefox";
      EDITOR = "hx";
      VISUAL = "hx";
      SUDO_EDITOR = "hx";
      TERMINAL = "ghostty";
      IMAGE = "feh";
      IMAGE_DESKTOP = "feh-image-viewer";
      VIDEO = "mpv";
      AUDIO = "clementine";
      PDF_DESKTOP = "org.kde.okular.desktop";
      # Window manager
      WM = "Hyprland";

      # Shell history
      HISTFILE = "${paths.xdg.cache}/zsh/.zsh_history";

      # Language-specific history
      NODE_REPL_HISTORY = "${paths.xdg.cache}/node/.node_repl_history";
      PYTHON_HISTORY = "${paths.xdg.cache}/python/.python_history";
      LESSHISTFILE = "/dev/null";

      # VI mode settings
      KEYTIMEOUT = 1;
    };
  };
}
