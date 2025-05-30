{ config, lib, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./behaviour.nix
  ];
}
