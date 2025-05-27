{ lib, pkgs, ... }:

{
  formatters = {
    iconFormatter = import ./formatters/iconFormatter.nix { inherit lib; };
  };

  generators = {
    assetLinker = import ./generators/assetLinker.nix;
    desktopGenerators = import ./generators/desktopGenerators.nix;
    pathGenerators = import ./generators/pathGenerators.nix;
    scriptLinker = import ./generators/scriptLinker.nix;
  };
}
