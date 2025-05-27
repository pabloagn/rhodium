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
    dark = {
      colors = {
        base00 = colorTokens.abyss.n950;
        base01 = colorTokens.wraith.n900;
        base02 = colorTokens.wraith.n800;
        base03 = colorTokens.wraith.n400;
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
  };
}
