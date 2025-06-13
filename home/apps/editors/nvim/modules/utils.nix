{ pkgs, sourceLuaFile }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Git Integration
      {
        # TODO: Add config 
        plugin = gitsigns-nvim; # Add inline git signs
        # config = sourceLuaFile "gitsigns-nvim.lua";
      }
      # {
      #   plugin = neogit;
      #   config = sourceLuaFile "gitsigns-nvim.lua";
      # }
      {
        plugin = octo-nvim;
        config = sourceLuaFile "octo-nvim.lua";
      }

      # Utilities
      {
        plugin = plenary-nvim;
      }
      {
        plugin = venn-nvim; # Ability to detach from cursor position (ASCII design mode)
        config = sourceLuaFile "venn-nvim.lua";
      }
    ];
  };
}
