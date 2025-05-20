# home/environment/variables.nix

{ lib, config, pkgs, flakeRootPath, ... }:

with lib;
let
  cfg = config.rhodium.home.environment.variables;
  preferredApps = config.rhodium.home.environment.preferredApps;

  rhodiumPaths = import ../lib/paths.nix {
    inherit lib config;
    flakeRootPath = flakeRootPath;
  };

  pathVariables = rhodiumPaths.mkSessionVariables;

  paths = rhodiumPaths.paths;
in
{
  options.rhodium.home.environment.variables = {
    enable = mkEnableOption "Rhodium's environment variables";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = pathVariables // {

      # Default applications
      BROWSER = preferredApps.browser or "firefox";
      EDITOR = preferredApps.editor or "hx";
      VISUAL = preferredApps.editor or "hx";
      SUDO_EDITOR = preferredApps.editor or "hx";
      TERMINAL = preferredApps.terminal or "ghostty";
      IMAGE = preferredApps.image or "feh";
      IMAGE_DESKTOP = preferredApps.image or "feh-image-viewer";
      VIDEO = preferredApps.video or "mpv";
      AUDIO = preferredApps.audio or "clementine";
      PDF_DESKTOP = preferredApps.pdf or "org.kde.okular.desktop";

      # Window manager
      WM = preferredApps.wm or "hyprland";

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
