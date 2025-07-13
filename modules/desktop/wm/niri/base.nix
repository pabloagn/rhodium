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
  };

  services.dbus = {
    enable = true; # Required for niri wm
  };

  # Desktop portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-termfilechooser # Portal for using TUIs as file pickers
    ];
    config = {
      common = {
        default = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr"; # NOTE: This is required for screensharing to work properly
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
    };
  };
}
