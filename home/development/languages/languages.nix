{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc # GNU compiler collection
    gnumake # GNU compiler
    go
    just # Alternative to Make
    nodejs
    # python3
    rustup # Rust toolchain installer
    texlive.combined.scheme-full # Complete texlive distribution
    typst # New markup-based tool
  ];
}
