{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption types;

  # Base paths - defined once
  xdgDataHome = config.xdg.dataHome;
  xdgConfigHome = config.xdg.configHome;
  xdgCacheHome = config.xdg.cacheHome;
  xdgStateHome = config.xdg.stateHome;
  homeDirectory = config.home.homeDirectory;

  # Derived paths
  iconsPath = "${xdgDataHome}/icons";
  logosPath = "${iconsPath}/logos";
  fontsPath = "${xdgDataHome}/fonts";
  wallpapersPath = "${xdgDataHome}/wallpapers";
  localBinPath = "${homeDirectory}/.local/bin";
in

{
  # Data
  xdgDataPaths = {
    icons = iconsPath;
    logos = logosPath;
    wallpapers = wallpapersPath;
  };

  # Fonts
  fontPaths = {
    user = fontsPath;
    system = "/run/current-system/sw/share/fonts";
    homeManager = "${homeDirectory}/.local/share/fonts";
  };

  # Executables
  scriptPaths = {
    user = localBinPath;
    xdg = "${xdgDataHome}/../bin";
    system = "/usr/local/bin";
  };

  # Application-specific
  appDataPaths = {
    config = xdgConfigHome;
    data = xdgDataHome;
    cache = xdgCacheHome;
    state = xdgStateHome;
  };

  # Helper functions
  generators = {
    # Generate icon path for specific app
    getIconPath = appName: "${iconsPath}/${appName}";

    # Generate logo path for specific app
    getLogoPath = logoName: "${logosPath}/${logoName}";

    # Generate wallpaper path for specific category
    getWallpaperPath = category: "${wallpapersPath}/${category}";

    # Generate app-specific data directory
    getAppDataPath = appName: "${xdgDataHome}/${appName}";

    # Generate app-specific config directory
    getAppConfigPath = appName: "${xdgConfigHome}/${appName}";

    # Generate app-specific cache directory
    getAppCachePath = appName: "${xdgCacheHome}/${appName}";

    # Generate font path for specific font family
    getFontPath = fontFamily: "${fontsPath}/${fontFamily}";

    # Generate script path for specific script
    getScriptPath = scriptName: "${localBinPath}/${scriptName}";
  };

  # Ensure directories exist (for use in activation scripts)
  ensureDirectories = [
    xdgDataHome
    iconsPath
    logosPath
    wallpapersPath
    fontsPath
    localBinPath
  ];
}
