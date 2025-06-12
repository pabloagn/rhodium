{ ... }:

{
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
  };

  xdg.configFile = {
    "nvim/lua/functions.lua".source = ./functions.lua;
    "nvim/lua/main.lua".source = ./main.lua;
    "nvim/lua/filters.lua".source = ./filters.lua;
    "nvim/lua/keybinds.lua".source = ./keybinds.lua;

    "nvim/init.lua".text = ''
      require('filters')
      require('functions')
      require('main')
      require('keybinds')
    '';
  };
}
