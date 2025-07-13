{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Hyprtools
    hyprpicker
    hyprlock
    hypridle

    # Utils
    wl-clipboard # Wayland clipboard
    wlr-randr # Xrandr clone for wlroots compositors
    libinput
    libinput-gestures
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
