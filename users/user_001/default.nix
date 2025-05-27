{ user, theme, ... }:

{
  imports = [
    ../../home/assets/themes

    # Extra Modules
    ../../home/environment
    ../../home/modules

    # Main Modules
    ../../home/apps
    ../../home/development
    ../../home/security
    ../../home/shells
    ../../home/utils
    ../../home/virtualization
  ];

  theme = theme;

  preferredApps = {
    browser = "firefox";
    editor = "hx";
    terminal = "ghostty";
    imageViewer = "feh";
    videoPlayer = "mpv";
    audioPlayer = "clementine";
    pdfViewer = "zathura";
    wm = "hyprland";
    pager = "most";
  };

  # Desktop Entries
  desktop = {
    apps.enable = true;
    profiles.enable = true;
    bookmarks.enable = true;
  };

  # Script Linking
  # WARNING: All scripts included here are included in PATH by default.
  scripts.enable = true;

  home = {
    username = user.username or "user";
    homeDirectory = "/home/${user.username}";
    stateVersion = "25.05";
  };
}
