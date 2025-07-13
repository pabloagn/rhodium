{ pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # --- General Requirements ---
    nixpkgs-fmt
    nixd
    nil
    git
    ripgrep
    sd
    fd
    pv
    fzf
    bat
    hyperfine

    # --- Requirements For Cache Building ---
    python3
    python3Packages.wcwidth
  ];
}
