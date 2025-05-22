# lib/default.nix

/*
  This file contains the entry point for rhodiumLib.
*/

{ lib, flakeRootPath, pkgs, pkgs-unstable, inputs, ... }:

let
  # Rhodium Metadata
  rhodiumGlobalMetadata = {
    appName = "Rhodium";
    authorName = "Pablo Aguirre";
    authorEmail = "main@pabloagn.com";
    version = "0.1.0";
  };

  # Paths
  paths = import ./paths { inherit lib flakeRootPath; };
  rhodiumPaths = paths.rhodium;
  xdgPaths = paths.xdgNames;
  launchableAppPaths = paths.launchableAppCategories;

  # Entry point for rhodiumPaths
  rhodiumRootDir = rhodiumPaths.root;
  rhodiumAssetsDir = rhodiumPaths.assets.assetsDir;
  rhodiumDataDir = rhodiumPaths.data.dataDir;
  rhodiumHomeDir = rhodiumPaths.home.homeDir;
  rhodiumLibDir = rhodiumPaths.lib.libDir;
  rhodiumModulesDir = rhodiumPaths.modules.modulesDir;
  rhodiumOverlaysDir = rhodiumPaths.overlays.overlaysDir;
  rhodiumScriptsDir = rhodiumPaths.scripts.scriptsDir;

  # Entry point for rhodiumLib
  rhodiumPathsLib = rhodiumPaths.lib;

  # rhodiumLib submodules
  desktopLib = import rhodiumPathsLib.desktopDir { inherit lib pkgs pkgs-unstable inputs; };
  optionsLib = import rhodiumPathsLib.optionsDir { inherit lib; };
  inspectorsLib = import rhodiumPathsLib.inspectorsDir { inherit lib; };

  # New assets module
  assetsLib = import rhodiumPathsLib.assetsDir { inherit lib pkgs pkgs-unstable inputs; };

  # Theme resolution function that uses the flake root path
  mkThemeResolver = { flakeRootPath }:
    let
      colorGenerators = assetsLib.colorGenerators { inherit lib pkgs; };
    in {
      # Main theme resolution function
      resolveTheme = themeName:
        colorGenerators.resolveTheme {
          inherit flakeRootPath themeName;
        };

      # Convenience function to get just colors
      getThemeColors = themeName:
        let theme = colorGenerators.resolveTheme { inherit flakeRootPath themeName; };
        in theme.colors;

      # Utility to convert any HSL color to HEX
      hslToHex = colorGenerators.hslToHex;

      # Access to all color utilities
      colorUtils = colorGenerators.colorUtils;
    };

  mkUserRhodiumPaths = homeDirParam: {
    assetsDir = "${homeDirParam}/${xdgPaths.data}/rhodium/assets";
    scriptsDir = "${homeDirParam}/${xdgPaths.bin}/rhodium/scripts";
  };
in
{
  # Original exports
  inherit (optionsLib) mkIndividualPackageOptions getEnabledPackages mkChildConfig;
  paths = rhodiumPaths;
  metadata = rhodiumGlobalMetadata;

  # New theme system - requires flakeRootPath to be provided
  # Usage: rhodiumLib.theme.resolveTheme "phantom"
  theme = mkThemeResolver { inherit flakeRootPath; };

  # Direct access to assets library
  assets = assetsLib;

  generateAllDesktopEntries = currentFullConfig:
    let
      browsersPathList = [ "rhodium" "home" "apps" "browsers" ];
      browsersConfig = lib.getAttrFromPath browsersPathList currentFullConfig;

      desktopConstants = desktopLib.desktopConstants {
        inherit lib pkgs inputs;
        paths = rhodiumPaths;
        config = currentFullConfig;
      };

      activeGenerators = desktopLib.desktopGenerators {
        inherit lib pkgs;
        constants = desktopConstants;
        config = currentFullConfig;
        paths = rhodiumPaths;
      };

      desktopEntryGenerators = desktopLib.entryGeneration {
        inherit lib activeGenerators;
      };

      profileItems = desktopEntryGenerators.generateProfileLauncherItems {
        profilesConfig = browsersConfig.profiles or { };
        allBrowsersConfig = browsersConfig;
      };

      bookmarkItems = desktopEntryGenerators.generateBookmarkLauncherItems {
        bookmarksConfig = browsersConfig.bookmarks or { };
      };

      applicationItems = desktopEntryGenerators.generateApplicationLauncherItems {
        launchableAppCategoriesData = launchableAppPaths;
        inherit currentFullConfig;
      };

    in
    lib.filter (item: item != null) (
      profileItems ++ bookmarkItems ++ applicationItems
    );

  mkXdgSessionVariables = homeDir: {
    "XDG_BIN_HOME" = "${homeDir}/${xdgPaths.bin}";
    "XDG_CACHE_HOME" = "${homeDir}/${xdgPaths.cache}";
    "XDG_CONFIG_HOME" = "${homeDir}/${xdgPaths.config}";
    "XDG_DATA_HOME" = "${homeDir}/${xdgPaths.data}";
    "XDG_STATE_HOME" = "${homeDir}/${xdgPaths.state}";
  };

  mkRhodiumSessionVariables = homeDir:
    let
      userRhodium = mkUserRhodiumPaths homeDir;
      pathsToEnvVars = prefix: pathSet:
        let
          flatten = p: attrs:
            lib.concatMapAttrs
              (name: value:
                if builtins.isAttrs value && !(lib.hasAttr "outPath" value)
                then flatten "${p}_${lib.toUpper name}" value
                else { "${p}_${lib.toUpper name}" = toString value; }
              )
              attrs;
        in
        flatten prefix pathSet;
    in
    {
      "RHODIUM_ROOT" = rhodiumRootDir;
      "RHODIUM_USER_ASSETS_DIR" = userRhodium.assetsDir;
      "RHODIUM_USER_SCRIPTS_DIR" = userRhodium.scriptsDir;
    } // pathsToEnvVars "RHODIUM_FLAKE_ASSETS" rhodiumPaths.assets
    // pathsToEnvVars "RHODIUM_FLAKE_SCRIPTS" rhodiumPaths.scripts;

  mkRhodiumFileLinks = homeDir:
    let
      userRhodium = mkUserRhodiumPaths homeDir;
    in
    {
      "${userRhodium.assetsDir}" = {
        source = rhodiumAssetsDir;
        recursive = true;
      };
      "${userRhodium.scriptsDir}" = {
        source = rhodiumScriptsDir;
        recursive = true;
        executable = true;
      };
    };
}
