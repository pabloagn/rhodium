{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = false;
    wayland.enable = true;

    theme = "catppuccin-mocha";

    settings = {
      General = {
        DefaultSession = "hyprland";

        # Display configuration
        DisplayServer = "wayland";
        GreeterEnvironment = "QT_WAYLAND_FORCE_DPI=physical,QT_WAYLAND_DISABLE_WINDOWDECORATION=1";

        # Input configuration
        Numlock = "on";

        # User configuration
        RememberLastUser = true;
        RememberLastSession = true;

        # Timeout settings
        LoginTimeout = 60;
        SessionTimeout = 30;
      };

      Users = {
        # User filtering
        MinimumUid = 1000;
        MaximumUid = 60000;
        HideUsers = "";
        HideShells = "/bin/false,/usr/bin/nologin,/sbin/nologin";
        RememberLastUser = true;
      };

      Wayland = {
        # Wayland-specific settings
        SessionDir = "/run/current-system/sw/share/wayland-sessions";
        CompositorCommand = "kwin_wayland --no-lockscreen --no-global-shortcuts --locale1";
      };

      X11 = {
        # X11 fallback settings
        SessionDir = "/run/current-system/sw/share/xsessions";
        XephyrPath = "/run/current-system/sw/bin/Xephyr";
        DisplayCommand = "/run/current-system/sw/bin/sddm-helper --start-server";
        DisplayStopCommand = "/run/current-system/sw/bin/sddm-helper --stop-server";
      };
    };
  };

  # Install Catppuccin theme for SDDM
  environment.systemPackages = with pkgs; [
    # SDDM themes
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Inter";
      fontSize = "12";
      background = "${./../../home/assets/wallpapers/dante/wallpaper-01.jpg}";
      loginBackground = true;
    })

    # Required packages
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtmultimedia

    # Fonts
    inter
  ];

  # Copy wallpaper for SDDM
  environment.etc."sddm/wallpaper.jpg".source = ../../home/assets/wallpapers/dante/wallpaper-01.jpg;

  # Enable required services
  services.xserver = {
    enable = true;
    displayManager.sessionPackages = [pkgs.hyprland];
  };

  # Qt and theming
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  # PAM configuration for keyring integration
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.sddm-greeter.enableGnomeKeyring = true;

  # Polkit for proper authentication
  security.polkit.enable = true;

  # Additional Qt/Wayland environment variables
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_WAYLAND_FORCE_DPI = "physical";
  };
}
