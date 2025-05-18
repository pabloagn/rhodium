# modules/core/default.nix

{ config, lib, pkgs, modulesPath,... }:

{
  imports = [
    (modulesPath + "/hardware/network/broadcom-43xx.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    ./boot.nix
    ./filesystem.nix
    ./hardware
    ./networking
    ./security
    ./system
    ./services
  ];
}
