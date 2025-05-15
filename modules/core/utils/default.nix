# modules/core/utils/default.nix
{ lib, config, pkgs, modulesPath,... }:

{
  imports = [
    ./utils.nix
  ];
}
