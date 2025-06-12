{ pkgs, rhodiumLib, ... }:

let
  pluginsDir = ../plugins;
  sourceLuaFile = rhodiumLib.parsers.luaParsers.sourceLuaFile pluginsDir;
in
{
  imports = [
    (import ./coding.nix { inherit pkgs sourceLuaFile; })
    (import ./editor.nix { inherit pkgs sourceLuaFile; })
    (import ./lsp.nix { inherit pkgs sourceLuaFile; })
    (import ./ui.nix { inherit pkgs sourceLuaFile; })
    (import ./themes.nix { inherit pkgs sourceLuaFile; })
    (import ./utils.nix { inherit pkgs sourceLuaFile; })
  ];
}
