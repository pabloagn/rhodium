# modules/themes/apply.nix

{ config, lib, pkgs, ... }:

let
  allAtomicTokens = import ../../assets/tokens/default.nix { inherit pkgs lib; };

  # Import the function that can map atomic tokens to semantic roles based on palette name
  resolveSemanticMappingsFn = import ../../assets/tokens/semantic/default.nix {
    inherit lib;
    resolvedAtoms = allAtomicTokens; # Pass atomic tokens to the semantic resolver
  };

  selectedThemeName = config.mySystem.theme.name;
  allThemeDefinitionFunctions = import ../../assets/themes/definitions/default.nix;
  selectedThemeFn = allThemeDefinitionFunctions."${selectedThemeName}" or null;

  userFontChoices = {
    primary = config.mySystem.theme.font.primary;
    monospace = config.mySystem.theme.font.monospace;
    defaultSize = config.mySystem.theme.font.defaultSize;
  };

  activeTheme = if selectedThemeFn != null
                then selectedThemeFn {
                  inherit lib;
                  resolvedAtoms = allAtomicTokens;
                  resolvedSemanticsFn = resolveSemanticMappingsFn.mapToSemanticColors;
                  inherit userFontChoices;
                }
                else {};
  finalTokens = activeTheme.tokens or {};

in
{
  config = lib.mkIf (selectedThemeFn != null && finalTokens != {}) {

    fonts.fontconfig.defaultFonts = {
      sansSerif = [ finalTokens.typography.primaryInterface.family.fontconfigName "sans-serif" ];
      serif = [ finalTokens.typography.primaryInterface.family.fontconfigName "serif" ];
      monospace = [ finalTokens.typography.monospace.family.fontconfigName "monospace" ];
    };

    # Example for Alacritty (assumes Home Manager for user 'pabloagn')
    # Replace 'pabloagn' with your actual primary username or a more generic user iteration.
    home-manager.users.pabloagn.programs.alacritty = {
      enable = true; # Assume enabled by a profile or other config
      settings = {
        font = {
          normal.family = finalTokens.typography.monospace.family.fontconfigName;
          size = lib.strings.removeSuffix "pt" finalTokens.typography.monospace.size;
        };
        colors = {
          primary = {
            background = finalTokens.colors.pageBackground;
            foreground = finalTokens.colors.textPrimary;
          };
          cursor = {
            text = finalTokens.colors.pageBackground; # Or selectionForeground
            cursor = finalTokens.colors.accentPrimary;
          };
          selection = {
            text = finalTokens.colors.selectionForeground;
            background = finalTokens.colors.selectionBackground;
          };
          # Map terminal colors: finalTokens.terminalPalette has keys like 'termBlack', 'termRed', etc.
          # Alacritty expects 'black', 'red', etc.
          normal = {
            black = finalTokens.terminalPalette.termBlack;
            red = finalTokens.terminalPalette.termRed;
            green = finalTokens.terminalPalette.termGreen;
            yellow = finalTokens.terminalPalette.termYellow;
            blue = finalTokens.terminalPalette.termBlue;
            magenta = finalTokens.terminalPalette.termMagenta;
            cyan = finalTokens.terminalPalette.termCyan;
            white = finalTokens.terminalPalette.termWhite;
          };
          bright = {
            black = finalTokens.terminalPalette.termBrightBlack;
            red = finalTokens.terminalPalette.termBrightRed;
            green = finalTokens.terminalPalette.termBrightGreen;
            yellow = finalTokens.terminalPalette.termBrightYellow;
            blue = finalTokens.terminalPalette.termBrightBlue;
            magenta = finalTokens.terminalPalette.termBrightMagenta;
            cyan = finalTokens.terminalPalette.termBrightCyan;
            white = finalTokens.terminalPalette.termBrightWhite;
          };
        };
      };
    };
    # TODO: Add other application theming here (GTK, Hyprland, etc.)
    # using values from `finalTokens`.
  };
}
