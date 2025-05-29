{ config, lib, pkgs, ... }:

{
  imports = [
    ./assets.nix
    ./desktop.nix
    ./preferences.nix
    ./scripts.nix
  ];
}
