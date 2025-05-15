# modules/core/users/default.nix
{ lib, config, pkgs, modulesPath,... }:

{
  imports = [
    ./users.nix
  ];
}
