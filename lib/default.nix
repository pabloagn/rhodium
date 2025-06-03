{ lib, pkgs, config, ... }:

{
  formatters = {
    iconFormatter = import ./formatters/iconFormatter.nix { };
  };
  generators = {
    desktopGenerators = import ./generators/desktopGenerators.nix { inherit lib config; };
    # pathGenerators = import ./generators/pathGenerators.nix { inherit lib pkgs config; }; # This is completely unecessary
  };
}
