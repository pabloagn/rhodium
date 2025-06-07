{ ... }:
let
  luaFiles = builtins.concatStringsSep "\n" [
    (builtins.readFile ./main.lua)
    (builtins.readFile ./ui.lua)
    (builtins.readFile ./keybinds.lua)
  ];
in
{
  imports = [./plugin];

  programs.neovim = {
    extraLuaConfig = luaFiles;
  };
}
