{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottom # Better htop alternative
    btop # Better htop alternative
    mesa-demos # OpenGL & Mesa tools (glxinfo, glxgears, etc.)
    hyperfine # Command-line benchmarking tool
    nmon # System monitoring tool
    psmisc # killall, pstree, etc.
    lm_sensors # Tools for reading hardware sensors
  ];
}
