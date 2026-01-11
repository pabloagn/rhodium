{ pkgs, ... }:
{
  imports = [
    ./bottom.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    procs # Rustified ps
    htop # Classic process viewer
    glances # Swiss Army knife monitor with web dashboard
    zenith # System monitor with zoomable charts
  ];
}
