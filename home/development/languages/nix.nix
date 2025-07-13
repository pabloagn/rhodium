{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Nix ---
    nil # Original language server
    nixd # Latest language server
    # nixpkgs-fmt # Formatter
    nixfmt-rfc-style # Official formatter
    # alejandra # Opinionated formatter
  ];
}
