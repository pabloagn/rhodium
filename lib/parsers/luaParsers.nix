{ lib, ... }:

let
  # Core function to source Lua files from a given directory
  sourceLuaFileFromDir = dir: file: "lua << EOF\n${builtins.readFile (dir + "/${file}")}\nEOF\n";

  # Convenience function that returns a sourceLuaFile function for a specific directory
  sourceLuaFile = dir: sourceLuaFileFromDir dir;

  # Enhanced version that validates file existence
  sourceLuaFileSafe =
    dir: file:
    let
      filePath = dir + "/${file}";
    in
    if builtins.pathExists filePath then
      sourceLuaFileFromDir dir file
    else
      builtins.throw "Lua file not found: ${toString filePath}";

  #Source multiple Lua files and concatenate them
  sourceLuaFiles =
    dir: files:
    let
      luaContents = map (file: builtins.readFile (dir + "/${file}")) files;
      concatenated = lib.concatStringsSep "\n" luaContents;
    in
    "lua << EOF\n${concatenated}\nEOF\n";

  # Conditionally source Lua files based on file existence
  sourceLuaFileConditional =
    dir: file: fallback:
    let
      filePath = dir + "/${file}";
    in
    if builtins.pathExists filePath then sourceLuaFileFromDir dir file else fallback;

in
{
  inherit
    sourceLuaFile
    sourceLuaFileFromDir
    sourceLuaFileSafe
    sourceLuaFiles
    sourceLuaFileConditional
    ;
}
