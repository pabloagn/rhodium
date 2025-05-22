# lib/inspectors/packageInspectors.nix

{ lib }:

{
  inspectPackage = { package }:
    lib.debug.runCommand "inspect-package" { } ''
      echo "Inspecting package: ${package}"
    '';
}
