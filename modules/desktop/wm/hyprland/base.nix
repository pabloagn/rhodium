{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    hyprpicker

    # TODO: Set up this
    # hyprlock
    # hypridle

    # Utils
    wl-clipboard # Wayland clipboard
    wlr-randr # Xrandr clone for wlroots compositors
    libinput
    libinput-gestures
    # polkit_gnome Authentication agent (sudo GUI prompts)
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Desktop portals
  # TODO: Customize this (desktop dialogues, etc)
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
