# lib/desktop/constants.nix

{ lib, pkgs, inputs ? {}, paths }:
with lib;
let
  mkLogoPath = logoFileName: "${paths.assets.logos}/${logoFileName}";
in
{
  # This map is ONLY for exceptions where logo filename != key, or for aliases.
  # Most logos will be found by convention (key.png).
  explicitLogoMap = {
    "firefox" = mkLogoPath "firefox_general.png"; # Example: if we want "firefox" key to always point here
    "custom_app_icon" = mkLogoPath "some-weirdly-named-file.png"; # Exception
    "my_editor_alias" = mkLogoPath "helix.png"; # Alias
    "system_default_web" = mkLogoPath "generic_web.png"; # Generic fallback
    "system_default_app" = mkLogoPath "generic_app.png"; # Generic fallback
  };

  # Default key to use for logo if no specific key is provided and convention fails
  defaultLogoKey = {
    webBookmark = "system_default_web";
    application = "system_default_app";
  };

  genericStrings = { /* ... */ };
  defaultCategories = { /* ... */ };
  browserExecutables = { /* ... */ };
  defaultTerminalCommand = config.home.sessionVariables.TERMINAL or "${pkgs.kitty}/bin/kitty";
}
