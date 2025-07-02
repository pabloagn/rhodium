{
  pkgs,
  sourceLuaFile,
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Edit
      # ------------------------------------------------
      {
        plugin = nvim-spectre; # Find & replace
        config = sourceLuaFile "nvim-spectre.lua";
      }

      # File Explorer
      # ------------------------------------------------
      # {
      #   plugin = neo-tree-nvim; # Newer file tree alternative
      #   config = sourceLuaFile "neo-tree-nvim.lua";
      # }
      {
        plugin = nvim-tree-lua; # File tree
        config = sourceLuaFile "nvim-tree.lua";
      }
      {
        plugin = hydra-nvim; # Implementation of Emacs Hydra
        # config = sourceLuaFile "hydra-nvim.lua";
      }
      {
        plugin = yazi-nvim;
        config = sourceLuaFile "yazi-nvim.lua";
      }

      # Find
      # ------------------------------------------------
      {
        plugin = telescope-nvim; # Finder
        config = sourceLuaFile "telescope-nvim.lua";
      }
      telescope-frecency-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim
      telescope-live-grep-args-nvim
      telescope-project-nvim

      # Navigation
      # ------------------------------------------------
      {
        plugin = aerial-nvim;
        config = sourceLuaFile "aerial-nvim.lua";
      }
      # {
      #   plugin = flash-nvim;
      #   config = sourceLuaFile "flash-nvim.lua";
      # }
      {
        plugin = harpoon2;
        config = sourceLuaFile "harpoon2-nvim.lua";
      }
      # {
      #   plugin = leap-nvim;
      #   config = sourceLuaFile "leap-nvim.lua";
      # }
      {
        plugin = marks-nvim;
        config = sourceLuaFile "marks-nvim.lua";
      }
      # {
      #   plugin = outline-nvim;
      #   config = sourceLuaFile "outline-nvim.lua";
      # }
      # {
      #   plugin = vim-illuminate;
      #   config = sourceLuaFile "vim-illuminate.lua";
      # }

      # Productivity
      # ------------------------------------------------
      {
        plugin = indent-blankline-nvim; # Better indent
        config = sourceLuaFile "indent-blankline-nvim.lua";
      }
      # {
      #   plugin = mini-nvim;
      #   config = sourceLuaFile "mini-nvim.lua";
      # }
      # {
      #   plugin = persistence-nvim;
      #   config = sourceLuaFile "persistence-nvim.lua";
      # }
      # {
      #   plugin = project-nvim;
      #   config = sourceLuaFile "project-nvim.lua";
      # }
      {
        plugin = orgmode;
        # config = sourceLuaFile "orgmode-nvim.lua";
      }
      {
        plugin = snacks-nvim;
        config = sourceLuaFile "snacks-nvim.lua";
      }
      {
        plugin = todo-comments-nvim; # Better TODOs
        config = sourceLuaFile "todo-comments-nvim.lua";
      }
      {
        plugin = which-key-nvim; # Help with keybinds
        config = sourceLuaFile "which-key-nvim.lua";
      }
      # {
      #   plugin = tiny-inline-diagnostic-nvim; # Better inline diagnostics
      #   config = sourceLuaFile "tiny-inline-diagnostic-nvim.lua";
      # }
    ];
  };
}
