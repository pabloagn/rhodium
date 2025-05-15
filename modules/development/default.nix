# modules/development/default.nix

{ config, pkgs, ... }:

{
  imports = [
    ./virtualization
    ./editors
    ./languages
  ];
}
