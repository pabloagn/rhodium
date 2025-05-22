# lib/paths/default.nix

{ lib, flakeRootPath }:

let
  pathsGenerators = import ./pathsGenerators.nix { inherit lib flakeRootPath; };
in
{
  inherit (pathsGenerators) rhodium xdgNames launchableAppCategories;
}
