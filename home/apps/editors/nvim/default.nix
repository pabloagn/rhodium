{...}: {
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
  };

  xdg.configFile = {
    # init.lua
    "nvim/lua/functions.lua".source = ./functions.lua;
    "nvim/lua/main.lua".source = ./main.lua;
    "nvim/lua/filters.lua".source = ./filters.lua;
    "nvim/lua/keybinds.lua".source = ./keybinds.lua;

    # Filetype plugins (automatically loaded by Neovim)
    "nvim/ftplugin/tex.lua".source = ./ftplugin/tex.lua;
    "nvim/ftplugin/python.lua".source = ./ftplugin/python.lua;
    "nvim/ftplugin/markdown.lua".source = ./ftplugin/markdown.lua;

    "nvim/init.lua".text = ''
      require('filters')
      require('functions')
      require('main')
      require('keybinds')
    '';
  };
}
