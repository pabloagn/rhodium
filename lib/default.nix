{ lib, ... }:
{
  formatters = {
    iconFormatter = import ./formatters/iconFormatter.nix { };
  };
  generators = {
    desktopGenerators = import ./generators/desktopGenerators.nix { inherit lib; };
    utilsMetadataGenerators = import ./generators/utilsMetadataGenerators.nix { inherit lib; };
    moduleGenerators = import ./generators/moduleGenerators.nix { inherit lib; };
  };
  parsers = {
    luaParsers = import ./parsers/luaParsers.nix { inherit lib; };
  };
}
