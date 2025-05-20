# lib/default.nix

{ config, lib, pkgs, ... }:

{
  inherit (import ./options.nix { inherit lib; })
    mkIndividualPackageOptions;
}
