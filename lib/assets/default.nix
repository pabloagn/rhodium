# lib/assets/default.nix

{ lib, pkgs, pkgs-unstable, inputs ? { }, ... }:

let
  # Import color generators
  mkColorGenerators = argsForColorGen:
    import ./colorGenerators.nix argsForColorGen;

in
{
  # Main color generation system
  colorGenerators = mkColorGenerators;
}
