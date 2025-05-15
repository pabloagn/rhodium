# modules/core/system/default.nix

{ lib, config, pkgs, modulesPath,... }:

{
  imports = [
    ./base.nix
  ];
}
