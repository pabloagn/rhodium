{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Cursor
    hyprcursor

    # Color picker
    hyprpicker

    # TODO: Set up this
    # hyprlock
    # hypridle

    # Utils
    wl-clipboard # Wayland clipboard
    wlr-randr # Xrandr clone for wlroots compositors

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

  # We still need xserver for gdm
  services.xserver.enable = true;

  # TODO: Eventually we change this for hyprlock
  services.xserver.displayManager.gdm = {
    enable = true;
    # wayland = true;
  };

  # Desktop portals
  # TODO: Customize this (desktop dialogues, etc)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # TODO: Check if we need this
  # For swaylock/hyprlock to work as login manager
  # security.pam.services.swaylock = {};  # Also works for hyprlock
}
