# lib/assets/colorGenerators.nix

{ lib, pkgs, ... }:

let
  # HSL to HEX conversion utility
  hslToHex = { h, s, l }:
    let
      # Normalize values
      hue = h / 360.0;
      saturation = s / 100.0;
      lightness = l / 100.0;

      # Helper function for HSL to RGB conversion
      hueToRgb = p: q: t:
        let
          t' = if t < 0 then t + 1 else if t > 1 then t - 1 else t;
        in
          if t' < 1.0 / 6.0 then p + (q - p) * 6.0 * t'
          else if t' < 1.0 / 2.0 then q
          else if t' < 2.0 / 3.0 then p + (q - p) * (2.0 / 3.0 - t') * 6.0
          else p;

      # Convert HSL to RGB
      rgbValues =
        if saturation == 0 then
          # Achromatic (gray)
          { r = lightness; g = lightness; b = lightness; }
        else
          let
            q = if lightness < 0.5
                then lightness * (1 + saturation)
                else lightness + saturation - lightness * saturation;
            p = 2 * lightness - q;
          in {
            r = hueToRgb p q (hue + 1.0 / 3.0);
            g = hueToRgb p q hue;
            b = hueToRgb p q (hue - 1.0 / 3.0);
          };

      # Convert to 0-255 range and format as hex
      toHex = val:
        let
          intVal = builtins.floor (val * 255 + 0.5);
          hexChars = [ "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F" ];
          high = builtins.elemAt hexChars (intVal / 16);
          low = builtins.elemAt hexChars (intVal - (intVal / 16) * 16);
        in "${high}${low}";

    in "#${toHex rgbValues.r}${toHex rgbValues.g}${toHex rgbValues.b}";

  # Color manipulation utilities
  lighten = { h, s, l }: amount: { inherit h s; l = lib.min 100 (l + amount); };
  darken = { h, s, l }: amount: { inherit h s; l = lib.max 0 (l - amount); };
  saturate = { h, s, l }: amount: { inherit h l; s = lib.min 100 (s + amount); };
  desaturate = { h, s, l }: amount: { inherit h l; s = lib.max 0 (s - amount); };

  # Fixed adjustHue without modulus operator
  adjustHue = { h, s, l }: amount:
    let
      newHue = h + amount;
      normalizedHue =
        if newHue >= 360 then newHue - 360
        else if newHue < 0 then newHue + 360
        else newHue;
    in { inherit s l; h = normalizedHue; };

  # Generate color with alpha
  withAlpha = color: alpha: color // { a = alpha; };

  # Generate color scale from base color
  generateScale = baseColor: steps:
    let
      stepSize = 80 / (steps - 1);
      generateStep = i:
        let
          lightness = 95 - (i * stepSize);
        in baseColor // { l = lightness; };
    in lib.genList generateStep steps;

  # Convert color palette to HEX recursively
  paletteToHex = palette:
    lib.mapAttrsRecursive (path: value:
      if lib.isAttrs value && value ? h && value ? s && value ? l
      then hslToHex value
      else value
    ) palette;

  # Load color constants from assets
  loadColorConstants = flakeRootPath:
    import "${flakeRootPath}/assets/colors/colors.nix";

  # Generate theme-specific color mappings
  generateThemeColors = { flakeRootPath, themeName, colorMappings }:
    let
      colorConstants = loadColorConstants flakeRootPath;
      rawColors = colorConstants.colors;

      # Apply theme-specific color mappings
      themeColors = lib.mapAttrs (semanticName: colorPath:
        if lib.isString colorPath then
          # Simple path like "slate.800"
          lib.getAttrFromPath (lib.splitString "." colorPath) rawColors
        else if lib.isAttrs colorPath && colorPath ? base then
          # Color with modifications like { base = "slate.500"; lighten = 10; }
          let
            baseColor = lib.getAttrFromPath (lib.splitString "." colorPath.base) rawColors;
            modifiedColor = lib.foldl (color: modification:
              if modification.type == "lighten" then lighten color modification.amount
              else if modification.type == "darken" then darken color modification.amount
              else if modification.type == "saturate" then saturate color modification.amount
              else if modification.type == "desaturate" then desaturate color modification.amount
              else if modification.type == "adjustHue" then adjustHue color modification.amount
              else color
            ) baseColor (colorPath.modifications or []);
          in modifiedColor
        else colorPath
      ) colorMappings;

      # Convert to HEX for easy consumption
      themeColorsHex = paletteToHex themeColors;
    in {
      hsl = themeColors;
      hex = themeColorsHex;
      raw = rawColors;
    };

  # Load theme assets (colors, fonts, etc.)
  loadThemeAssets = { flakeRootPath, themeName }:
    let
      themeFile = "${flakeRootPath}/assets/themes/${themeName}.nix";
      themeExists = builtins.pathExists themeFile;
    in
      if themeExists then
        let
          themeDefinition = import themeFile { inherit lib; };
          colorSystem = generateThemeColors {
            inherit flakeRootPath themeName;
            colorMappings = themeDefinition.colors or {};
          };
        in themeDefinition // {
          colors = colorSystem;
          _meta = {
            name = themeName;
            loaded = true;
            assetsPath = "${flakeRootPath}/assets";
          };
        }
      else
        throw "Theme '${themeName}' not found at ${themeFile}";

  # Generate wallpaper paths for theme
  generateWallpaperPaths = { flakeRootPath, themeName }:
    let
      wallpaperDir = "${flakeRootPath}/assets/wallpapers/${themeName}";
      wallpaperDirExists = builtins.pathExists wallpaperDir;
    in
      if wallpaperDirExists then
        let
          # This would need to be enhanced to actually read directory contents
          # For now, we'll generate expected paths
          generateWallpaperPath = num: "${wallpaperDir}/wallpaper-${lib.fixedWidthString 2 "0" (toString num)}.jpg";
        in {
          primary = generateWallpaperPath 1;
          all = lib.genList (i: generateWallpaperPath (i + 1)) 11;
          directory = wallpaperDir;
        }
      else {
        primary = null;
        all = [];
        directory = null;
      };

  # Main theme resolver function
  resolveTheme = { flakeRootPath, themeName }:
    let
      themeAssets = loadThemeAssets { inherit flakeRootPath themeName; };
      wallpapers = generateWallpaperPaths { inherit flakeRootPath themeName; };
    in themeAssets // {
      wallpapers = wallpapers;
    };

in {
  # Core utilities
  inherit hslToHex lighten darken saturate desaturate adjustHue withAlpha;
  inherit generateScale paletteToHex;

  # High-level functions
  inherit loadColorConstants generateThemeColors loadThemeAssets;
  inherit generateWallpaperPaths resolveTheme;

  # Convenience functions
  colorUtils = {
    inherit lighten darken saturate desaturate adjustHue withAlpha;
    inherit generateScale;
  };
}
