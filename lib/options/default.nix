# lib/options/default.nix

{ lib }:

let
  optionsGenerators = import ./optionsGenerators.nix { inherit lib; };
in
{
  inherit (optionsGenerators) mkIndividualPackageOptions getEnabledPackages mkChildConfig mkAppModuleOptions;
}
