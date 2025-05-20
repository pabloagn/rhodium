# modules/default.nix

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./core/default.nix
    ./desktop/default.nix
    ./development/default.nix
  ];
}
