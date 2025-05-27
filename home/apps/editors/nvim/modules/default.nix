{ ... }:
let
  luaFiles = builtins.concatStringsSep "\n" [
    (builtins.readFile ./main.lua)
    (builtins.readFile ./ui.lua)
    (builtins.readFile ./keybinds.lua)
  ];
in
{
  programs.neovim = {
    extraLuaConfig = luaFiles;
  };
}
