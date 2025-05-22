# home/environment/paths.nix

# Path-specific environment module

{ lib, config, pkgs, self, ... }:

with lib;
let
  cfg = config.rhodium.environment.paths;

  # Import the path helper
  rhodiumPaths = import ../lib/paths.nix {
    inherit lib config;
    flakeRoot = self;
  };
in
{
  options.rhodium.environment.paths = {
    enable = mkEnableOption "Rhodium's path configuration";
  };

  config = mkIf cfg.enable {
    home.file = rhodiumPaths.mkFileLinks.assetLinks // rhodiumPaths.mkFileLinks.scriptLinks;
    home.sessionPath = [
      rhodiumPaths.paths.rhodium.dirs.scripts
      rhodiumPaths.paths.xdg.bin
    ];
    xdg = {
      enable = true;
      cacheHome = rhodiumPaths.paths.xdg.cache;
      configHome = rhodiumPaths.paths.xdg.config;
      dataHome = rhodiumPaths.paths.xdg.data;
      stateHome = rhodiumPaths.paths.xdg.state;
    };
  };
}
