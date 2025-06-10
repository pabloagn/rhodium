{ ... }:

let
  luaFiles = builtins.concatStringsSep "\n" [
    (builtins.readFile ./main.lua)
    (builtins.readFile ./filters.lua)
    (builtins.readFile ./ui.lua)
    (builtins.readFile ./keybinds.lua)
  ];
in
{
  imports = [./plugins];

  programs.neovim = {
    extraLuaConfig = luaFiles;
  };
}

