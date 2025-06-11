{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst
    libnotify
    # tiramisu
    # mako # Lightweight Wayland notification daemon
  ];
}
