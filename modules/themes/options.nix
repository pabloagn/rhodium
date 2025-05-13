# modules/themes/options.nix

{ lib, config, pkgs, ... }:

let
  availableFontKeys = lib.attrNames (
    import ../../assets/tokens/fonts/definitions.nix { inherit pkgs lib; }
  );
  availableThemeKeys = lib.attrNames (
    import ../../assets/themes/definitions/default.nix
  );
in
{
  options.mySystem.theme = {
    name = lib.mkOption {
      type = lib.types.enum availableThemeKeys;
      default = "srcl";
      description = "The active system-wide visual theme.";
      example = "phantom";
    };

    font = {
      primary = lib.mkOption {
        type = lib.types.enum availableFontKeys;
        default = "Inter";
        description = "Primary interface font for the selected theme.";
      };
      monospace = lib.mkOption {
        type = lib.types.enum availableFontKeys;
        default = "JetBrainsMono";
        description = "Default monospace font for terminals and code for the selected theme.";
      };
      defaultSize = lib.mkOption {
        type = lib.types.str;
        default = "10pt";
        description = "Default base font size for the theme (e.g., '10pt', '11px').";
      };
    };
  };
}
