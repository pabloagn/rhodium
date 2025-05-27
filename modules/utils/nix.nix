{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style      # Format nix code
    nix-btm               # Bottom-like system monitor for nix
    nix-direnv            # Fast direnv integration
    nix-du                # Disk usage analyzer for nix store
    nix-index             # File database for nix packages
    nix-ld                # Run unpatched binaries on NixOS
    nix-melt              # Ranger-like flake.lock viewer
    nix-output-monitor    # Better nix build output
    nix-search            # Search nix packages
    nix-top               # Top-like process monitor for nix
    nix-tree              # Explore nix store
    nix-update            # Update nix package versions
    nix-web               # Web interface for nix store
  ];
}
