# hosts/native/default.nix

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ../../modules/core/hardware
    ../../modules/core/shell
    ../../modules/core/system
    ../../modules/desktop
    ../../modules/core/utils
    ../../modules/development
  ];
}
