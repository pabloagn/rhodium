{ user, theme, userExtras, rhodiumLib, userPreferences, host, ... }:

{
  imports = [
    # Themes
    ../../home/assets/themes

    # Extra Modules
    ../../home/environment
    ../../home/modules

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
    wallpapers.enable = true;
  };

  # Script linking
  # NOTE: Enables all scripts in home/scripts with chmod +x
  scripts.enable = true;

  home = {
    username = user.username or "user_001";
    homeDirectory = "/home/${user.username or "user_001"}";
    stateVersion = "25.05";
  };
}
