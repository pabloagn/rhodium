{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dunst
    libnotify
    # tiramisu # Desktop notifications
    # mako # Lightweight Wayland notification daemon
  ];
}
