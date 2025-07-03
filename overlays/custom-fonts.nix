# overlays/packages/custom-fonts.nix

final: prev:

let
  lib = prev.lib;
  stdenvNoCC = prev.stdenvNoCC;
  customFontsRoot = ../../assets/fonts;
  mkFontPackage = fontDirName: fontDirPath:

    let
      metaFile = fontDirPath + "/fontmeta.nix";
      fontMetadata =
        if builtins.pathExists metaFile
        then import metaFile
        else {
          fontType = "opentype";
          license = lib.licenses.unfree;
          description = "Locally provided ${fontDirName} font";
        };
    in
    stdenvNoCC.mkDerivation {
      pname = lib.strings.toLower fontDirName;
      version = "local";
      src = fontDirPath;

      meta = {
        description = fontMetadata.description;
        license =
          if builtins.isString fontMetadata.license
          then lib.licenses.${fontMetadata.license} or lib.licenses.unfree
          else fontMetadata.license;
        platforms = lib.platforms.all;
      };

      installPhase = ''
        runHook preInstall
        font_type="${fontMetadata.fontType}" # Use from metadata

        install -d $out/share/fonts/$font_type
        # Only copy known font file types to avoid copying metadata files etc.
        # This is more robust than $src/*
        find $src -maxdepth 1 -type f \( -iname "*.otf" -o -iname "*.ttf" -o -iname "*.woff" -o -iname "*.woff2" \) -print0 | while IFS= read -r -d $'\0' file; do
          install -m444 "$file" "$out/share/fonts/$font_type/"
        done
        runHook postInstall
      '';

      dontBuild = true;
      dontFixup = true;
    };

  fontDirectories = lib.attrNames (lib.filterAttrs (name: type: type == "directory") (builtins.readDir customFontsRoot));
  customFontPackages = lib.listToAttrs (map
    (dirName: {
      name = dirName;
      value = mkFontPackage dirName (customFontsRoot + "/${dirName}");
    })
    fontDirectories);
in
customFontPackages
