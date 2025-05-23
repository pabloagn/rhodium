# lib/defaults/default.nix

/*
  This file contains the default values for the flake.
  Don't mess with it unless you know what you're doing.
*/

{ lib, ... }:

let
  themeDefaults = import ./themeDefaults.nix { inherit lib; };
  nameDefaults = import ./nameDefaults.nix { inherit lib; };
in
{
  inherit themeDefaults nameDefaults;
}
