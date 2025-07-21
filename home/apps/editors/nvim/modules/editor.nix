{
  pkgs,
  sourceLuaFile,
}:
{
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
        plugin = yazi-nvim; # Yazi on nvim
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
        plugin = aerial-nvim; # Outline view
        config = sourceLuaFile "aerial-nvim.lua";
      }
      {
        plugin = flash-nvim; # Motion improvement
        # TODO: Activate again, but check the config to be minimal and actually useful
        # config = sourceLuaFile "flash-nvim.lua";
      }
      {
        plugin = harpoon2; # Pin files and buffers for quick switch
        config = sourceLuaFile "harpoon2-nvim.lua";
      }
      {
        plugin = marks-nvim; # Set file marks and leap
        config = sourceLuaFile "marks-nvim.lua";
      }
      # {
      #   plugin = outline-nvim;
      #   config = sourceLuaFile "outline-nvim.lua";
      # }
      {
        plugin = vim-illuminate; # Automatically highlighting other uses of the word under the cursor
        config = sourceLuaFile "vim-illuminate-nvim.lua";
      }

      # Productivity
      # ------------------------------------------------
      {
        plugin = indent-blankline-nvim; # Better indent
        config = sourceLuaFile "indent-blankline-nvim.lua";
      }
      # {
      #   plugin = image-nvim; # Render images inside nvim (using Kitty protocol)
      #   config = sourceLuaFile "image-nvim.lua";
      # }
      # {
      #   plugin = mini-nvim;
      #   config = sourceLuaFile "mini-nvim.lua";
      # }
      # {
      #   plugin = persistence-nvim; # Automated session management
      #   config = sourceLuaFile "persistence-nvim.lua";
      # }
      # {
      #   plugin = project-nvim;
      #   config = sourceLuaFile "project-nvim.lua";
      # }
      {
        plugin = orgmode; # Emacs orgmode in nvim
        # config = sourceLuaFile "orgmode-nvim.lua";
      }
      {
        plugin = snacks-nvim; # Multiple goodies
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
      {
        plugin = zen-mode-nvim; # Zen mode
        # config = sourceLuaFile "zen-mode-nvim.lua";
      }
    ];
  };
}
