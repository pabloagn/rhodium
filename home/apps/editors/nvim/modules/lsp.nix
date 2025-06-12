{ pkgs, sourceLuaFile }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # LSP
      {
        plugin = nvim-lspconfig; # LSP
        config = sourceLuaFile "nvim-lspconfig.lua";
      }
      # {
      #   plugin = neoconf-nvim;
      #   config = sourceLuaFile "neoconf-nvim.lua";
      # }
      # {
      #   plugin = none-ls-nvim;
      #   config = sourceLuaFile "none-ls-nvim.lua";
      # }
      # Loading animations
      fidget-nvim # Loading animations

      # Diagnostics
      {
        plugin = trouble-nvim;
        config = sourceLuaFile "trouble-nvim.lua";
      }
    ];
  };
}
