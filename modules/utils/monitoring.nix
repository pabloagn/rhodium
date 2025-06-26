{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    psmisc # killall, pstree, etc.
    bottom # Better htop alternative
    btop # Better htop alternative
    nmon # System monitoring tool
    hyperfine # Command-line benchmarking tool
    glxinfo # Info for OpenGL & Mesa
  ];
}
