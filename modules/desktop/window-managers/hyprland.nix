# modules/desktop/window-managers/hyprland.nix

# Minimal system-level support for Hyprland environments
{ config, pkgs, lib, ... }: {
  # programs.hyprland.enable = false; # Hyprland program itself is now managed by Home Manager

  # Ensure essential XDG Desktop Portal for Hyprland is available system-wide
  # This is crucial for features like screen sharing, file pickers in Flatpaks, etc.
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    hyprlock
    libnotify
  ];

  # TODO: Display Manager: Configure it to offer a Hyprland session.

}
