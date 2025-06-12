{ pkgs, sourceLuaFile }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Git Integration
      # {
      #   plugin = gitsigns-nvim;
      #   config = sourceLuaFile "gitsigns-nvim.lua";
      # }
      # {
      #   plugin = octo-nvim;
      #   config = sourceLuaFile "octo-nvim.lua";
      # }

      # Utilities
      {
        plugin = plenary-nvim;
        config = sourceLuaFile "plenary-nvim.lua";
      }
    ];
  };
}
