{ lib, pkgs, ... }:

{
  formatters = {
    iconFormatter = import ./formatters/iconFormatter.nix { };
  };
  generators = {
    desktopGenerators = import ./generators/desktopGenerators.nix { inherit lib; };
  };
}
