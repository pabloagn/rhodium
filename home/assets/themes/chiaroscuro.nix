{ pkgs, ... }:
let
  colorTokens = import ../colors/colors.nix;
  fontTokens = import ../fonts/fonts.nix { inherit pkgs; };
  iconsNerdFontTokens = import ../icons/nerdfonts.nix;
  iconsUnicodeTokens = import ../icons/unicode.nix;
  wallpaperTokens = import ../wallpapers/wallpapers.nix;
in
{
  theme = {
    name = "chiaroscuro";
    description = "A high-contrast dark theme with elegant typography";

    dark = {
      colors = {
        base00 = colorTokens.abyss.n950;
        base01 = colorTokens.wraith.n900;
        base02 = colorTokens.wraith.n800;
        base03 = colorTokens.wraith.n100;
        base04 = colorTokens.lacuna.n700;
        base05 = colorTokens.archangel.n900;
        base06 = colorTokens.archangel.n500;
        base07 = colorTokens.archangel.n50;
        base08 = colorTokens.ember.n400;
        base09 = colorTokens.icarus.n100;
        base0A = colorTokens.stardust.n100;
        base0B = colorTokens.absynthe.n500;
        base0C = colorTokens.absynthe.n300;
        base0D = colorTokens.cherenkov.n100;
        base0E = colorTokens.fugue.n100;
        base0F = colorTokens.xenon.n100;
        comment = colorTokens.extras."comment-dark";
        selection = colorTokens.extras."selection-dark";
        focus = colorTokens.cherenkov.n100;
        warm-surface = colorTokens.abyss.n500;
        error-surface = colorTokens.extras."error-surface-dark";
        info-surface = colorTokens.extras."info-surface-dark";
        success-surface = colorTokens.extras."success-surface-dark";
        warning-surface = colorTokens.extras."warning-surface-dark";
      };
      fonts = {
        fontFamilyMono = fontTokens.monospace.jetbrains-mono.name;
        fontFamilyMonoIcons = fontTokens.monospace.jetbrains-mono.name;
        fontSize = 14;
      };
      icons = {
        iconsNerdFont = iconsNerdFontTokens;
        iconsUnicode = iconsUnicodeTokens;
      };
      wallpapers = wallpaperTokens.dante;
    };

    light = {
      colors = {
        base00 = colorTokens.archangel.n50;
        base01 = colorTokens.archangel.n200;
        base02 = colorTokens.archangel.n300;
        base03 = colorTokens.lacuna.n500;
        base04 = colorTokens.lacuna.n700;
        base05 = colorTokens.wraith.n800;
        base06 = colorTokens.wraith.n900;
        base07 = colorTokens.abyss.n950;
        base08 = colorTokens.ember.n700;
        base09 = colorTokens.icarus.n800;
        base0A = colorTokens.stardust.n800;
        base0B = colorTokens.absynthe.n700;
        base0C = colorTokens.absynthe.n600;
        base0D = colorTokens.cherenkov.n500;
        base0E = colorTokens.fugue.n500;
        base0F = colorTokens.xenon.n500;
        comment = colorTokens.lacuna.n600;
        selection = colorTokens.extras."selection-light";
        focus = colorTokens.cherenkov.n500;
        warm-surface = colorTokens.ivory.n200;
        error-surface = colorTokens.extras."error-surface-light";
        info-surface = colorTokens.extras."info-surface-light";
        success-surface = colorTokens.extras."success-surface-light";
        warning-surface = colorTokens.extras."warning-surface-light";
      };
      fonts = {
        fontFamilyMono = fontTokens.monospace.jetbrains-mono.name;
        fontFamilyMonoIcons = fontTokens.monospace.jetbrains-mono.name;
        fontSize = 14;
      };
      icons = {
        iconsNerdFont = iconsNerdFontTokens;
        iconsUnicode = iconsUnicodeTokens;
      };
      wallpapers = wallpaperTokens.aria;
    };
  };
}
