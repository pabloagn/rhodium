# hosts/native-vb/default.nix

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ../../modules/core/hardware
    ../../modules/core/shell
    ../../modules/core/system
    ../../modules/core/users
    ../../modules/desktop
    ../../modules/core/utils
    ../../modules/development
  ];
}
