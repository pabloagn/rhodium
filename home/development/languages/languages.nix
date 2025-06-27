{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc # GNU compiler collection
    gnumake # GNU compiler
    go
    nodejs
    python3
    rustup # Rust toolchain installer
    just # Alternative to Make
    texlive.combined.scheme-full # Complete texlive distribution
    typst # New markup-based tool
  ];
}
