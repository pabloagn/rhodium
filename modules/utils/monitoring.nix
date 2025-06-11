{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    psmisc # killall, pstree, etc.
    # htop # System monitoring
    bottom # Better htop alternative
    # nmon # System monitoring tool
    # btop # Better htop alternative
    hyperfine # Command-line benchmarking tool
  ];
}
