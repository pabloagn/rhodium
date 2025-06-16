{
  lib,
  pkgs,
  ...
}: let
  fontDefinitions = import ../assets/fonts/fonts.nix {inherit pkgs;};
  isFontEnabled = fontDef: fontDef ? enable && fontDef.enable == true;

  getFontPackages = fontDef: let
    mainPackage = lib.optional (fontDef.package != null) fontDef.package;
    extraPackages = fontDef.extraPackages or [];
  in
    mainPackage ++ extraPackages;

  collectEnabledFonts = categoryFonts:
    lib.pipe categoryFonts [
      (lib.filterAttrs (_: isFontEnabled))
      (lib.mapAttrsToList (_: getFontPackages))
      lib.flatten
    ];

  enabledFontPackages = lib.pipe fontDefinitions [
    (lib.mapAttrsToList (_: collectEnabledFonts))
    lib.flatten
  ];
in {
  fonts.fontconfig.enable = true;
  home.packages = enabledFontPackages;

  # NOTE: List all installed fonts for debugging
  home.file.".local/share/fonts-installed.txt".text = let
    enabledFontsList = lib.pipe fontDefinitions [
      (lib.mapAttrsToList (
        categoryName: categoryFonts:
          lib.pipe categoryFonts [
            (lib.filterAttrs (_: isFontEnabled))
            (lib.mapAttrsToList (fontName: fontDef: "${categoryName}/${fontName}: ${fontDef.name}"))
          ]
      ))
      lib.flatten
      (lib.concatStringsSep "\n")
    ];
  in "# Installed Fonts\n# Generated automatically\n\n${enabledFontsList}\n";
}
