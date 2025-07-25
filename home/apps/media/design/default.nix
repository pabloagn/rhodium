{ pkgs, ... }:
{
  imports = [
    ./blender.nix
    ./figma.nix
    ./gimp.nix
    ./inkscape.nix
  ];
}
