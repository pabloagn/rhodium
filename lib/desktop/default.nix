# lib/desktop/default.nix

{ lib, pkgs, pkgs-unstable, inputs ? {}, ... }:

let

  rawMkDesktopConstants = import ./desktopConstants.nix;

  finalMkDesktopConstants = callTimeArgs:
    rawMkDesktopConstants (callTimeArgs // {
      inherit pkgs-unstable inputs;
    });

  mkActiveGenerators = argsForGenerators:
    let
      internalConstants = argsForGenerators.constants;
    in
    import ./desktopGenerators.nix {
      inherit (argsForGenerators) lib pkgs config paths;
      desktopConstants = internalConstants;
    };

  mkEntryGeneration = argsForEntryGen:
    import ./entryGenerators.nix argsForEntryGen;

in
{
  desktopConstants = finalMkDesktopConstants;
  desktopGenerators = mkActiveGenerators;
  entryGeneration = mkEntryGeneration;
}
