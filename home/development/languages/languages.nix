{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    gnumake
    go
    nodejs
    python3
    rustup
    just
    texlive.combined.scheme-full
    typst
  ];
}
