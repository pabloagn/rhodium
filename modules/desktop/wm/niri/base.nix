{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard support
    wayland-utils # Wayland debugging tools
    wev # Key event viewer (useful for finding key names)
    wlr-randr # Output management
    xwayland-satellite # X11 app support (non-native on niri)
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland

    # XDG directories
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";

    # For Qt apps
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    SDL_VIDEODRIVER = "wayland"; # For SDL apps
  };

  programs.niri = {
    enable = true;
  };

  # Desktop portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
    };
  };
}
