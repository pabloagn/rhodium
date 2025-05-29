{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style # Format nix code - useful system-wide
    nix-index # File database for nix packages - benefits all users
    nix-ld # Run unpatched binaries on NixOS - needs system-wide access
  ];
}
