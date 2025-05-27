{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    go
    nodejs
    python3
    rustup
    texlive.combined.scheme-full
  ];
}
