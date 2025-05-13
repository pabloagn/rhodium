# assets/themes/definitions/srcl.nix

{ lib, resolvedAtoms, resolvedSemanticsFn, userFontChoices }:

let
  # Get semantic colors by applying the mapping to the "srcl" palette
  semanticColors = resolvedSemanticsFn "srcl";

  chosenFont = resolvedAtoms.fonts.definitions."${userFontChoices.primary}";
  chosenMonoFont = resolvedAtoms.fonts.definitions."${userFontChoices.monospace}";
in
{
  name = "SRCL Direct"; # Metadata for the theme
  tokens = {
    colors = semanticColors;
    typography = {
      primaryInterface = {
        family = chosenFont; # Full font definition object
        size = userFontChoices.defaultSize;
      };
      monospace = {
        family = chosenMonoFont;
        size = userFontChoices.defaultSize; # Can be made more specific, e.g., resolvedAtoms.fonts.sizes.srclDefault
      };
    };
    borderRadius = resolvedAtoms.borders.radii.none;
    terminalPalette = semanticColors.terminal; # Contains the map of terminal colors
  };
}
