# hosts/host-0003/default.nix

{ config, lib, pkgs, modulesPath, userData, hostData, rhodium, ... }:

{
  imports = [
    rhodium.system.core.system
    rhodium.system.core.users
    rhodium.system.core.shell
    rhodium.system.desktop
    rhodium.system.core.utils
    rhodium.system.development
  ];
}
