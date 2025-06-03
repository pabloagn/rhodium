{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style # Format nix code - useful system-wide
    nix-ld # Run unpatched binaries on NixOS - needs system-wide access
  ];
}
