{ ... }:

let
  luaFiles = builtins.concatStringsSep "\n" [
    (builtins.readFile ./filters.lua)
    (builtins.readFile ./main.lua)
    (builtins.readFile ./keybinds.lua)
  ];
in
{
  imports = [
    ./modules
  ];

  programs.neovim = {
    extraLuaConfig = luaFiles;
  };
}
