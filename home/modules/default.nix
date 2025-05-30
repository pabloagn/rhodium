{ config, lib, pkgs, ... }:

{
  imports = [
    ./assets.nix
    ./desktop.nix
    ./fonts.nix
    ./preferences.nix
    ./scripts.nix
  ];
}
