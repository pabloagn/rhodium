{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nil # Nix language server (original)
    nixd # Nix language server (newer)
    nixpkgs-fmt # Formatter
    nixfmt-rfc-style # Official formatter
    alejandra # Opinionated formatter
    nix-ld # Run unpatched binaries on NixOS - needs system-wide access
  ];
}
