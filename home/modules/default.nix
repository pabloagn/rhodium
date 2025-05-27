{ config, lib, pkgs, ... }:

{
  imports = [
    ./assets.nix
    ./desktop.nix
    ./scripts.nix
  ];
}
