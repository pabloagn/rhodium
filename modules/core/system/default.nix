# modules/core/system/default.nix

{ lib, config, pkgs, modulesPath, hostData, ... }:

{
  imports = [
    ./extra.nix
    ./garbage.nix
  ];
}
