{ lib, pkgs, ... }:

{
  formatters = {
    iconFormatter = import ./formatters/iconFormatter.nix { };
  };
  generators = {
    desktopGenerators = import ./generators/desktopGenerators.nix { inherit lib; };
    # pathGenerators = import ./generators/pathGenerators.nix { inherit lib pkgs config; }; # This is completely unecessary
  };
}
