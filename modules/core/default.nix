# modules/core/default.nix

{ config, lib, pkgs, modulesPath,... }:

{
  imports = [
    (modulesPath + "/hardware/network/broadcom-43xx.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    ./boot/default.nix
    ./filesystem/default.nix
    ./groups/groups.nix
    ./hardware/default.nix
    ./networking/default.nix
    ./security/default.nix
    ./shell/shell.nix
    ./system/default.nix
    ./users/users.nix
    ./utils/utils.nix
  ];
}
