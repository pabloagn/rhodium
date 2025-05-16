# assets/fonts/fonts.nix

let
  getDirectories = dir:
    let
      contents = builtins.readDir dir;
      dirFilter = name: type: type == "directory" && builtins.pathExists (dir + "/${name}/fontmeta.nix");
      dirNames = builtins.filter (name: dirFilter name contents.${name}) (builtins.attrNames contents);
    in
      dirNames;

  getFontFiles = fontDir:
    let
      contents = builtins.readDir (./. + "/${fontDir}");
      isFont = name: type: type == "regular" && (lib.hasSuffix ".otf" name || lib.hasSuffix ".ttf" name);
      fontFiles = builtins.filter (name: isFont name contents.${name}) (builtins.attrNames contents);
      fontPaths = map (file: {
        name = file;
        path = ./. + "/${fontDir}/${file}";
      }) fontFiles;
    in
      fontPaths;

  getFontInfo = fontDir:
    let
      meta = import (./. + "/${fontDir}/fontmeta.nix");
      fontFiles = getFontFiles fontDir;
      fontInfo = {
        inherit (meta) fontName fontType fontLicense;
        fontFiles = fontFiles;
        directory = fontDir;
      };
    in
      fontInfo;

  fontDirs = getDirectories ./.;
  lib = (import <nixpkgs> {}).lib;
  allFonts = builtins.listToAttrs (map
    (dir: {
      name = dir;
      value = getFontInfo dir;
    })
    fontDirs
  );

in {
  fonts = allFonts;
  fontDirectories = fontDirs;
}
