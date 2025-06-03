{ config, userPreferences, ... }:

{
  # Environment vars
  home.sessionVariables = {
    # App Preferences
    BROWSER = userPreferences.apps.browser;
    EDITOR = userPreferences.apps.editor;
    VISUAL = userPreferences.apps.editor;
    SUDO_EDITOR = userPreferences.apps.editor;
    TERMINAL = userPreferences.apps.terminal;
    IMAGE_VIEWER = userPreferences.apps.imageViewer;
    VIDEO_PLAYER = userPreferences.apps.videoPlayer;
    AUDIO_PLAYER = userPreferences.apps.audioPlayer;
    PDF_VIEWER = userPreferences.apps.pdfViewer;
    WM = userPreferences.apps.wm;
    PAGER = userPreferences.apps.pager;
    MANPAGER = userPreferences.apps.pager;

    # XDG and other vars
    RHODIUM = "${config.home.homeDirectory}/rhodium";
    XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin"; # Not set by NixOS so setting here
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    HISTFILE = "${config.xdg.cacheHome}/zsh/.zsh_history";
    NODE_REPL_HISTORY = "${config.xdg.cacheHome}/node/.node_repl_history";
    PYTHON_HISTORY = "${config.xdg.cacheHome}/python/.python_history";
    LESSHISTFILE = "/dev/null";
    KEYTIMEOUT = "1";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}
