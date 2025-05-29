{ config, lib, pkgs, userPreferences, userExtras, rhodiumLib, ... }:

let
  # Generate all desktop entries using rhodium lib
  generatedEntries = rhodiumLib.generators.desktopGenerators.generateAllEntries
    userPreferences
    userExtras;

  # Create YAML configuration for raffi launcher
  yamlFormat = pkgs.formats.yaml {};
  raffiConfig = yamlFormat.generate "raffi.yaml" generatedEntries;

  # Helper to safely quote arguments for .desktop files
  escapeDesktopArg = arg:
    if lib.hasInfix " " arg
    then ''"${arg}"''
    else arg;

  # Convert entries to .desktop file format
  toDesktopEntry = name: entry: {
    name = entry.description;
    exec = "${entry.binary} ${lib.concatStringsSep " " (map escapeDesktopArg entry.args)}";
    icon = entry.icon;
    type = "Application";
    categories = if lib.hasInfix "firefox" entry.binary || lib.hasInfix "zen" entry.binary || lib.hasInfix "chromium" entry.binary
      then [ "Network" "WebBrowser" ]
      else if lib.hasInfix "ghostty" entry.binary || lib.hasInfix "kitty" entry.binary
      then [ "System" "TerminalEmulator" ]
      else [ "Utility" "Application" ];
    terminal = false;
    startupNotify = true;
  };

in
{
  # Place raffi configuration in proper location
  xdg.configFile."raffi/raffi.yaml" = {
    source = raffiConfig;
  };

  # Generate .desktop files for system integration
  xdg.desktopEntries = lib.mapAttrs toDesktopEntry generatedEntries;

  # Debug file for inspection
  home.file."desktop-entries-debug.yaml" = {
    source = raffiConfig;
  };
}
