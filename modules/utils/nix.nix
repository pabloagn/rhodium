{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alejandra # Opinionated formatter
    nil # Nix language server (original)
    nix-ld # Run unpatched binaries on NixOS - needs system-wide access
    nixd # Nix language server (newer)
    nixfmt-rfc-style # Official formatter
    nixpkgs-fmt # Formatter
  ];
}
