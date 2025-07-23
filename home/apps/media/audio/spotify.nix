{ rhodiumLib, pkgs, ... }:

rhodiumLib.generators.moduleGenerators.mkAutoModule {
  name = "spotify";
  description = "Spotify music streaming";
  type = "package";
  packages = with pkgs; [ spotify ];
}
