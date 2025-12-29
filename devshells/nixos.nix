{ pkgs-shell, ... }:
pkgs-shell.mkShell {
  buildInputs = with pkgs-shell; [
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

    # --- Utils ---
    claude-code
    codex
    gemini-cli
  ];
}
