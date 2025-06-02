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
  # Desktop files need quotes around arguments containing special characters
  # and % characters must be escaped as %% to avoid field code interpretation
  escapeDesktopArg = arg:
    let
      # First escape % characters to avoid field code conflicts
      escapedPercent = lib.replaceStrings ["%"] ["%%"] arg;
      # Check if we need quotes due to special characters
      needsQuotes = lib.any (char: lib.hasInfix char arg) [ "?" "&" "=" " " ";" "|" "<" ">" "(" ")" "[" "]" "{" "}" "$" "`" "\\" "\"" "'" "\n" "\t" "#" ];
    in
    if needsQuotes
    then ''"${lib.escape [ "\\" "\"" ] escapedPercent}"''
    else escapedPercent;

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
  # home.file."desktop-entries-debug.yaml" = {
  #   source = raffiConfig;
  # };
}
