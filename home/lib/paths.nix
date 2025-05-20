# home/lib/paths.nix

{ lib, config, flakeRootPath }:

let
  corePaths = import ../../lib/modules/paths.nix {
    inherit lib config;
    flakeRootPath = flakeRootPath;
  };

  pathsToEnvVars = prefix: pathSet:
    let
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
  paths = corePaths;

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
        "RHODIUM_ROOT" = corePaths.rhodium.root;
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
        source = "${corePaths.rhodium.root}/assets";
        recursive = true;
      };
    };

    scriptLinks = {
      "${corePaths.rhodium.dirs.scripts}" = {
        source = "${corePaths.rhodium.root}/scripts";
        recursive = true;
        executable = true;
      };
    };
  };
}
