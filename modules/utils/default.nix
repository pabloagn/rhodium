{ config, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./filesystem.nix
    ./monitoring.nix
    ./networking.nix
    ./nix.nix
    ./text.nix
  ];
}
