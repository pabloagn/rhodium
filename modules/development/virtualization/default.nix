# modules/development/virtualization/default.nix

{ config, pkgs, ... }:

{
  imports = [
    ./docker.nix
  ];
}
