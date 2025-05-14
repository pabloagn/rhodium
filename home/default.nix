# home/default.nix

{ config, lib, pkgs, ... }:

{
  # Import our options
  imports = [
    ./options.nix
  ]
  # Import role configurations - these define CAPABILITIES
  ++ (map
    (role: ./roles/${role}.nix)
    (builtins.filter
      (role: builtins.pathExists ./roles/${role}.nix)
      config.myHome.roles))
  # Import profile configuration - this defines SOFTWARE
  ++ [
    (./profiles/${config.myHome.profile}.nix)
  ];

  # Common configuration for all users
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Basic shell configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
  };
}
