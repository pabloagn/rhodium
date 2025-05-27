# home/environment/variables.nix

{ lib, config, pkgs, pkgs-unstable, ... }:

with lib;
let
  cfg = config.preferredApps;
in
{
  options.preferredApps = {
    browser = mkOption {
      type = types.str;
      default = "firefox";
      description = "Default web browser";
    };

    editor = mkOption {
      type = types.str;
      default = "hx";
      description = "Default text editor";
    };

    terminal = mkOption {
      type = types.str;
      default = "ghostty";
      description = "Default terminal emulator";
    };

    imageViewer = mkOption {
      type = types.str;
      default = "feh";
      description = "Default image viewer";
    };

    videoPlayer = mkOption {
      type = types.str;
      default = "mpv";
      description = "Default video player";
    };

    audioPlayer = mkOption {
      type = types.str;
      default = "clementine";
      description = "Default audio player";
    };

    pdfViewer = mkOption {
      type = types.str;
      default = "zathura";
      description = "Default PDF viewer";
    };

    wm = mkOption {
      type = types.str;
      default = "hyprland";
      description = "Default window manager";
    };

    pager = mkOption {
      type = types.str;
      default = "most";
      description = "Default pager";
    };
  };

  # TODO: Assertions
  # User's environment variables
  config.home.sessionVariables = {
    BROWSER = cfg.browser;
    EDITOR = cfg.editor;
    VISUAL = cfg.editor;
    SUDO_EDITOR = cfg.editor;
    TERMINAL = cfg.terminal;
    IMAGE_VIEWER = cfg.imageViewer;
    VIDEO_PLAYER = cfg.videoPlayer;
    AUDIO_PLAYER = cfg.audioPlayer;
    PDF_VIEWER = cfg.pdfViewer;
    WM = cfg.wm;
    PAGER = cfg.pager;
    MANPAGER = cfg.pager;

    # NOTE: We needed to set this since NixOS doesn't have a default XDG_BIN_HOME
    XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin";

    # Application-specific variables
    HISTFILE = "${config.xdg.cacheHome}/zsh/.zsh_history";
    NODE_REPL_HISTORY = "${config.xdg.cacheHome}/node/.node_repl_history";
    PYTHON_HISTORY = "${config.xdg.cacheHome}/python/.python_history";
    LESSHISTFILE = "/dev/null";
    KEYTIMEOUT = "1";
  };

  # Environment variables which are included in PATH
  config.home.sessionPath = [
    config.home.sessionVariables.XDG_BIN_HOME
  ];
}
