# home/lib/paths.nix
# Home-specific path utilities for the Rhodium system

{ lib, config, flakeRoot }:

let
  # Import the core path definitions
  corePaths = import ../../lib/modules/paths.nix {
    inherit lib config flakeRoot;
  };

  # Convert paths to environment variables
  pathsToEnvVars = prefix: pathSet:
    let
      # Helper to flatten nested attribute sets with prefixed names
      flatten = prefix: attrs:
        lib.concatMapAttrs
          (name: value:
            if builtins.isAttrs value && !(lib.hasAttr "outPath" value)
            then flatten "${prefix}_${lib.toUpper name}" value
            else { "${prefix}_${lib.toUpper name}" = toString value; }
          )
          attrs;
    in
    flatten prefix pathSet;
in
{
  # The complete paths set for use in modules
  paths = corePaths;

  # Function to create environment variables from paths
  mkSessionVariables =
    let
      # Basic XDG variables
      xdgVars = {
        "XDG_BIN_HOME" = corePaths.xdg.bin;
        "XDG_CACHE_HOME" = corePaths.xdg.cache;
        "XDG_CONFIG_HOME" = corePaths.xdg.config;
        "XDG_DATA_HOME" = corePaths.xdg.data;
        "XDG_STATE_HOME" = corePaths.xdg.state;
      };

      # Rhodium-specific variables
      rhodiumVars = {
        "RHODIUM" = corePaths.rhodium.root;
      } // pathsToEnvVars "RHODIUM" {
        assets = corePaths.rhodium.assets;
        dirs = corePaths.rhodium.dirs;
        scripts = corePaths.rhodium.scripts;
      };
    in
    xdgVars // rhodiumVars;

  mkFileLinks = {

    assetLinks = {
      "${corePaths.rhodium.dirs.assets}" = {
        source = "${flakeRoot}/assets";
        recursive = true;
      };
    };

    scriptLinks = {
      "${corePaths.rhodium.dirs.scripts}" = {
        source = "${flakeRoot}/scripts";
        recursive = true;
        executable = true;
      };
    };
  };
}
