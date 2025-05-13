# assets/tokens/fonts/definitions.nix

{ pkgs, lib }:

{
  # Nixpkgs Fonts
  CommitMono = { fontconfigName = "CommitMono Nerd Font"; nixPackage = pkgs.nerdfonts.override { fonts = [ "CommitMono" ]; }; };
  JetBrainsMono = { fontconfigName = "JetBrains Mono"; nixPackage = pkgs.jetbrains-mono; };
  Inter = { fontconfigName = "Inter"; nixPackage = pkgs.inter; };

  # Custom Fonts
  ServerMono = { fontconfigName = "Server Mono"; nixPackage = pkgs.ServerMono; };
  
  
}
