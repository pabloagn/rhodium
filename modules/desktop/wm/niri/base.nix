{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard support
    wayland-utils # Wayland debugging tools
    wev # Key event viewer (useful for finding key names)
    wlr-randr # Output management
    pkgs-unstable.xwayland-satellite # X11 app support (non-native on niri)
    dragon-drop # Drag and drop for wayland
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland

    # XDG directories
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";

    # For Qt apps
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # For SDL apps
    SDL_VIDEODRIVER = "wayland";
  };

  programs.niri = {
    enable = true;
    # NOTE: Using nixpkgs niri instead of niri-flake package due to upstream
    # build failures (issues #1501, #1515). The niri-flake's cargoInstallHook
    # fails silently during install phase.
    package = pkgs.niri;
  };

  services.dbus = {
    enable = true; # Required for niri wm
  };

  # Desktop portals
  # NOTE: Niri requires xdg-desktop-portal-gnome for screencasting (not wlr).
  # The programs.niri module already adds xdg-desktop-portal-gnome and niri-portals.conf.
  xdg.portal = {
    enable = true;
    # wlr.enable = true; # DISABLED: wlr portal doesn't work with Niri
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      # xdg-desktop-portal # DISABLED: already pulled in by the niri module
      # xdg-desktop-portal-wlr # DISABLED: Niri uses gnome portal for ScreenCast
      xdg-desktop-portal-termfilechooser # Portal for using TUIs as file pickers
    ];
    # DISABLED: This config forced wlr for ScreenCast which doesn't work with Niri.
    # The niri package provides niri-portals.conf which correctly routes to gnome.
    # config = {
    #   common = {
    #     default = "gtk";
    #     "org.freedesktop.impl.portal.ScreenCast" = "wlr";
    #     "org.freedesktop.impl.portal.Screenshot" = "wlr";
    #   };
    # };
  };

  # Required by xdg-desktop-portal-gnome for file chooser dialogs
  services.dbus.packages = [ pkgs.nautilus ];
}
