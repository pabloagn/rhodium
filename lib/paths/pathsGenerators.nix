# lib/paths/pathsGenerators.nix

/**
 * This file contains the paths generators for the flake.
 */

{ lib, flakeRootPath }:
let
  pjoin = segments:
    /**
     * Join a list of segments into a path string.
     */
    lib.concatStringsSep "/" (
      lib.map (s: toString s) (lib.filter (s: s != null && toString s != "") segments)
    );
  flakeRootPathStr = toString flakeRootPath;
in
{
  rhodium = {
    root = flakeRootPathStr;
    assets = rec {
      assetsDir = pjoin [ flakeRootPathStr "assets" ];
      colorsDir = pjoin [ assetsDir "colors" ];
      fontsDir = pjoin [ assetsDir "fonts" ];
      iconsDir = pjoin [ assetsDir "icons" ];
      imagesDir = pjoin [ assetsDir "images" ];
      soundsDir = pjoin [ assetsDir "sounds" ];
      templatesDir = pjoin [ assetsDir "templates" ];
      themesDir = pjoin [ assetsDir "themes" ];
      wallpapersDir = pjoin [ assetsDir "wallpapers" ];
    };
    data = rec {
      dataDir = pjoin [ flakeRootPathStr "data" ];
      hostsDir = pjoin [ dataDir "hosts" ];
      usersDir = pjoin [ dataDir "users" ];
    };
    home = {
      homeDir = pjoin [ flakeRootPathStr "home" ];
    };
    lib = rec {
      libDir = pjoin [ flakeRootPathStr "lib" ];
      assetsDir = pjoin [ libDir "assets" ];
      desktopDir = pjoin [ libDir "desktop" ];
      optionsDir = pjoin [ libDir "options" ];
      inspectorsDir = pjoin [ libDir "inspectors" ];
      pathsDir = pjoin [ libDir "paths" ];
    };
    modules = {
      modulesDir = pjoin [ flakeRootPathStr "modules" ];
    };
    overlays = {
      overlaysDir = pjoin [ flakeRootPathStr "overlays" ];
    };
    scripts = rec {
      scriptsDir = pjoin [ flakeRootPathStr "scripts" ];
      desktop = rec {
        desktopDir = pjoin [ scriptsDir "desktop" ];
        desktopLaunchers = pjoin [ desktopDir "desktopLaunchers" ];
      };
      system = pjoin [ scriptsDir "system" ];
      utils = pjoin [ scriptsDir "utils" ];
    };
    secrets = {
      secretsDir = pjoin [ flakeRootPathStr "secrets" ];
    };
    tools = {
      toolsDir = pjoin [ flakeRootPathStr "tools" ];
    };
    usersDir = pjoin [ flakeRootPathStr "users" ];
  };
  xdgNames = {
    /**
     * Standard XDG directory names (relative string constants).
     * These are not absolute paths to a user's home but common relative names.
     */
    bin = ".local/bin";
    cache = ".cache";
    config = ".config";
    data = ".local/share";
    state = ".local/state";
  };
  launchableAppCategories = [
    /**
     * Launchable app categories.
     * These are categories of apps that can be launched by the user.
     */
    {
      optionPath = [ "rhodium" "home" "apps" "browsers" ];
      categoryLevelNonAppAttrs = [ "enable" "profiles" "bookmarks" ];
    }
    {
      optionPath = [ "rhodium" "home" "apps" "terminal" "emulators" ];
      categoryLevelNonAppAttrs = [ "enable" ];
    }
    {
      optionPath = [ "rhodium" "home" "development" "editors" ];
      categoryLevelNonAppAttrs = [ "enable" ];
    }
  ];
}
