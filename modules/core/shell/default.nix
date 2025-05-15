# modules/core/shell/default.nix

{ lib, config, pkgs, modulesPath,... }:

{
  imports = [
    ./shell.nix
  ];
}
