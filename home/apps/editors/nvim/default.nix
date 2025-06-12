{ ... }:

let
  luaFiles = builtins.concatStringsSep "\n" [
    # Define a lua package
    "package.path = package.path .. ';${./.}/?.lua'"

    # Read files
    (builtins.readFile ./functions.lua)
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
