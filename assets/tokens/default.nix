# assets/tokens/default.nix

{ pkgs, lib }:

{
  palettes = import ./palettes/default.nix;
  fonts = {
    definitions = import ./fonts/definitions.nix { inherit pkgs lib; };
    sizes = import ./fonts/sizes.nix;
  };
  borders = {
    radii = import ./borders/radii.nix;
  };
}
