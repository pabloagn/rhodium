{
  pkgs,
  sourceLuaFile,
}:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Bufferline
      {
        plugin = bufferline-nvim;
        config = sourceLuaFile "bufferline-nvim.lua";
      }
      # Dashboard
      # {
      #   plugin = alpha-nvim;
      #   config = sourceLuaFile "alpha-nvim.lua";
      # }
      {
        plugin = dashboard-nvim; # Entry dashboard
        config = sourceLuaFile "dashboard-nvim.lua";
      }
      # Icons
      nvim-web-devicons
      # Layout
      # {
      #   plugin = edgy-nvim;
      #   config = sourceLuaFile "edgy-nvim.lua";
      # }
      # Messages/Notifications
      {
        plugin = noice-nvim; # Niceties
        config = sourceLuaFile "noice-nvim.lua";
      }
      nui-nvim # Required by noice-nvim
      # Status line
      {
        plugin = lualine-nvim; # Status line
        config = sourceLuaFile "lualine-nvim.lua";
        # config = sourceLuaFile "evil-lualine-nvim.lua";
      }
      lualine-lsp-progress
    ];
  };
}
