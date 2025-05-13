# assets/themes/definitions/phantom.nix

{ lib, resolvedAtoms, resolvedSemanticsFn, userFontChoices }:

let
  semanticColors = resolvedSemanticsFn "phantom";
  chosenFont = resolvedAtoms.fonts.definitions."${userFontChoices.primary}";
  chosenMonoFont = resolvedAtoms.fonts.definitions."${userFontChoices.monospace}";
in
{
  name = "Phantom Direct";
  tokens = {
    colors = semanticColors;
    typography = {
      primaryInterface = { family = chosenFont; size = userFontChoices.defaultSize; };
      monospace = { family = chosenMonoFont; size = userFontChoices.defaultSize; };
    };
    borderRadius = resolvedAtoms.borders.radii.sm;
    terminalPalette = semanticColors.terminal;
  };
}
