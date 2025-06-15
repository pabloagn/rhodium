{
  lib,
  config,
  pkgs,
  userPreferences,
  userExtras,
  rhodiumLib,
  ...
}: let
  theme = config.theme;
  generatedEntries =
    rhodiumLib.generators.desktopGenerators.generateAllEntries userPreferences userExtras
    theme;

  # Create YAML configuration
  yamlFormat = pkgs.formats.yaml {};
  raffiConfig = yamlFormat.generate "raffi.yaml" generatedEntries;
  escapeDesktopArg = arg: let
    escapedPercent = lib.replaceStrings ["%"] ["%%"] arg;
    needsQuotes = lib.any (char: lib.hasInfix char arg) [
      "?"
      "&"
      "="
      " "
      ";"
      "|"
      "<"
      ">"
      "("
      ")"
      "["
      "]"
      "{"
      "}"
      "$"
      "`"
      "\\"
      "\""
      "'"
      "\n"
      "\t"
      "#"
    ];
  in
    if needsQuotes
    then ''"${lib.escape ["\\" "\""] escapedPercent}"''
    else escapedPercent;

  # Convert entry to .desktop file content
  # NOTE: This was required since xdg.desktopEntries was a mess
  entryToDesktopFile = name: entry: let
    categories =
      if
        lib.hasInfix "firefox" entry.binary
        || lib.hasInfix "zen" entry.binary
        || lib.hasInfix "chromium" entry.binary
      then "Network;WebBrowser"
      else if lib.hasInfix "ghostty" entry.binary || lib.hasInfix "kitty" entry.binary
      then "System;TerminalEmulator"
      else "Utility;Application";

    # Conditional X- fields based on entry type
    xFields =
      "X-Entry-Type=${entry.entryType}"
      + (
        if entry.entryType == "bookmark"
        then
          "\nX-Profile-Name=${entry.profileName or ""}"
          + "\nX-Category=${lib.concatStringsSep ";" (entry.categories or [])}"
        else if entry.entryType == "profile"
        then
          "\nX-Profile-Name=${entry.profileName or ""}"
          + "\nX-Category=${lib.concatStringsSep ";" (entry.categories or [])}"
        else if entry.entryType == "application"
        then "\nX-Category=${lib.concatStringsSep ";" (entry.categories or [])}"
        else ""
      );
  in ''
    [Desktop Entry]
    Type=Application
    Name=${entry.description}
    Exec=${entry.binary} ${lib.concatStringsSep " " (map escapeDesktopArg entry.args)}
    Icon=${entry.icon}
    Categories=${categories}
    Terminal=false
    StartupNotify=true
    Version=1.0
    ${xFields}
  '';

  # Create home.file entries for each desktop entry
  desktopFileEntries =
    lib.mapAttrs'
    (name: entry: {
      name = ".local/share/applications/${name}.desktop";
      value = {
        text = entryToDesktopFile name entry;
      };
    })
    generatedEntries;
in {
  xdg.configFile."raffi/raffi.yaml" = {
    source = raffiConfig;
  };

  # Create desktop files directly using home.file
  home.file = desktopFileEntries;
}
