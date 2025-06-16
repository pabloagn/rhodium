{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Core Wayland utilities
    wl-clipboard # Clipboard support
    wayland-utils # Wayland debugging tools
    wev # Key event viewer (useful for finding key names)

    # Display and graphics
    swaybg # Wallpaper daemon
    brightnessctl # Brightness control
    wlr-randr # Output management

    # Launcher (choose one or both)
    fuzzel # Recommended launcher for Wayland
    rofi-wayland # If you prefer rofi

    # Authentication agent
    # polkit_gnome # For GUI sudo prompts

    # XWayland support for X11 apps
    xwayland-satellite # Better X11 app support

    # Audio control
    pavucontrol # GUI audio control
    playerctl # Media player control
  ];

  environment.sessionVariables = {
    # Hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";

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

  # Desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };
}
