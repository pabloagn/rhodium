{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # alejandra # Opinionated formatter
    nil # Nix language server (original)
    nixd # Nix language server (newer)
    nixfmt-rfc-style # Official formatter
    # nixpkgs-fmt # Formatter
  ];
}
