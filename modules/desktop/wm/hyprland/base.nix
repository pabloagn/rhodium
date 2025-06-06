{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Cursor
    # hyprcursor

    # Color picker
    hyprpicker

    # TODO: Set up this
    # hyprlock
    # hypridle

    # Utils
    wl-clipboard # Wayland clipboard
    wlr-randr # Xrandr clone for wlroots compositors
    libinput
    libinput-gestures

    # Authentication agent(sudo GUI prompts)
    # polkit_gnome
  ];

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
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
