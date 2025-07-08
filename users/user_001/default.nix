{
  pkgs,
  userData,
  theme,
  userExtras,
  rhodiumLib,
  userPreferences,
  host,
  ...
}: {
  imports = [
    # Themes
    ../../home/assets/themes

    # Extra Modules
    ../../home/environment
    ../../home/modules
    ../../home/services

    # Main Modules
    ../../home/apps
    ../../home/desktop
    ../../home/development
    ../../home/security
    ../../home/shells
    ../../home/utils
    ../../home/virtualization
  ];

  # Pass args to all modules
  _module.args = {
    inherit userExtras userPreferences rhodiumLib host;
  };

  # Theme configuration
  theme = theme;

  # Asset linking
  assets = {
    wallpapers.enable = true; # Symlink wallpapers to data dir
    colors.enable = true; # Symlink color packs to user data dir
    icons.enable = true; # Symlink icon packs to user data dir
    ascii.enable = true; # Symlink ASCII art files to user data dir
  };

  # Script linking
  # WARN: Enables all scripts in home/scripts with chmod +x
  scripts = {
    enable = true;
  };

  # Custom services
  # NOTE: These are custom services located under home/services, and run as systemd daemons
  userExtraServices = {
    rh-ags.enable = true;
    rh-eww.enable = false;
    rh-mako.enable = false;
    rh-neovim-daemon.enable = false;
    rh-swaybg.enable = true;
    rh-system-keyring.enable = true;
    rh-waybar.enable = false;
    rh-wlsunset.enable = false;
  };

  home = {
    username = userData.user_001.username;
    homeDirectory = "/home/${userData.user_001.username}";
    stateVersion = "25.05";
  };
}
