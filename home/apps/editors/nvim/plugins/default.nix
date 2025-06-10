{ pkgs, ... }:

let
  sourceLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [

      # Core
      vim-nix

      # Languages
      {
        plugin = nvim-lspconfig; # LSP
        config = sourceLuaFile ./nvim-lspconfig.lua;
      }

      {
        plugin = nvim-cmp; # Completion engine
        config = sourceLuaFile ./nvim-cmp.lua;
      }

      cmp-buffer
      cmp-dictionary
      cmp-latex-symbols
      cmp-path # Path completion
      cmp-nixpkgs-maintainers
      cmp-nvim-lsp

      # Completion
      friendly-snippets # Lua snippets
      luasnip # Lua snippets engine

      # UI
      fidget-nvim # Loading animations

      {
        plugin = dashboard-nvim; # Entry dashboard
        config = sourceLuaFile ./dashboard-nvim.lua;
      }

      {
        plugin = noice-nvim; # Niceties
        config = sourceLuaFile ./noice-nvim.lua;
      }

      nui-nvim # Required by noice-nvim

      {
        plugin = nvim-tree-lua; # File tree
        config = sourceLuaFile ./nvim-tree.lua;
      }

      {
        plugin = todo-comments-nvim; # Better TODOs
        config = sourceLuaFile ./todo-comments-nvim.lua;
      }

      {
        plugin = lualine-nvim; # Status line
        config = sourceLuaFile ./lualine-nvim.lua;
        # config = sourceLuaFile ./evil-lualine-nvim.lua;
      }

      lualine-lsp-progress

      # Telescope
      {
        plugin = telescope-nvim; # Finder
        config = sourceLuaFile ./telescope-nvim.lua;
      }

      telescope-fzf-native-nvim # Finder + fz
      telescope-live-grep-args-nvim
      telescope-project-nvim # TODO: Add this config

      # Improvements
      {
        plugin = comment-nvim;
        config = sourceLuaFile ./comment-nvim.lua;
      }

      {
        plugin = tokyonight-nvim;
        config = sourceLuaFile ./tokyonight-nvim.lua;
      }

      # Utils
      {
        plugin = indent-blankline-nvim; # Better indent
        config = sourceLuaFile ./indent-blankline-nvim.lua;
      }

      {
        plugin = nvim-colorizer-lua; # Add colors to color codes
        config = sourceLuaFile ./nvim-colorizer-lua.lua;
      }

      {
        plugin = vimtex;
        config = sourceLuaFile ./vimtex.lua;
      }

      nvim-treesitter-context
      nvim-treesitter-textobjects

      # {
      #   plugin = plenary-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = mini-nvim;
      #   config = sourceLuaFile ./mini-nvim.lua;
      # }

      # {
      #   plugin = ts-comments-nvim;
      #   config = sourceLuaFile ./ts-comments-nvim.lua;
      # }

      # {
      #   plugin = lazydev-nvim;
      #   config = sourceLuaFile ./lazydev-nvim.lua;
      # }

      # {
      #   plugin = bufferline-nvim;
      #   config = sourceLuaFile ./bufferline-nvim.lua;
      # }

      # {
      #   plugin = yazi-nvim;
      #   config = sourceLuaFile ./yazi-nvim.lua;
      # }

      # {
      #   plugin = flash-nvim;
      #   config = sourceLuaFile ./flash-nvim.lua;
      # }

      # {
      #   plugin = refactoring-nvim;
      #   config = sourceLuaFile ./refactoring-nvim.lua;
      # },

      # {
      #   plugin = alpha-nvim;
      #   config = sourceLuaFile ./;
      # },
      # {
      #   plugin = none-ls-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = crates-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = neoconf-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = edgy-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = octo-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = which-key-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = project-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = gitsigns-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = trouble-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = conform-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = nvim-lint;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = nui-nvim;
      #   config = sourceLuaFile ./;
      # }

      {
        plugin = snacks-nvim;
        config = sourceLuaFile ./snacks-nvim.lua;
      }

      # {
      #   plugin = persistence-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = blink-cmp;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = neogen;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = nvim-dap;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = aerial-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = fzf-vim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = harpoon2;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = vim-illuminate;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = leap-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = neo-tree-nvim;
      #   config = sourceLuaFile ./;
      # }

      # {
      #   plugin = outline-nvim;
      #   config = sourceLuaFile ./;
      # }

      {
        plugin = multicursors-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = (
          nvim-treesitter.withPlugins (p: [
            p.tree-sitter-bash
            p.tree-sitter-c
            p.tree-sitter-clojure
            p.tree-sitter-commonlisp
            p.tree-sitter-csv
            p.tree-sitter-dart
            p.tree-sitter-dockerfile
            p.tree-sitter-elixir
            p.tree-sitter-elm
            p.tree-sitter-erlang
            p.tree-sitter-fortran
            p.tree-sitter-go
            p.tree-sitter-graphql
            p.tree-sitter-haskell
            p.tree-sitter-hcl
            p.tree-sitter-html
            p.tree-sitter-http
            p.tree-sitter-hyprlang
            p.tree-sitter-ini
            p.tree-sitter-java
            p.tree-sitter-javascript
            p.tree-sitter-json
            p.tree-sitter-julia
            p.tree-sitter-kotlin
            p.tree-sitter-latex
            p.tree-sitter-lua
            p.tree-sitter-luadoc
            p.tree-sitter-make
            p.tree-sitter-markdown
            p.tree-sitter-markdown-inline
            p.tree-sitter-nix
            p.tree-sitter-nu
            p.tree-sitter-ocaml
            p.tree-sitter-odin
            p.tree-sitter-perl
            p.tree-sitter-php
            p.tree-sitter-python
            p.tree-sitter-r
            p.tree-sitter-rasi
            p.tree-sitter-regex
            p.tree-sitter-ruby
            p.tree-sitter-rust
            p.tree-sitter-scss
            p.tree-sitter-solidity
            p.tree-sitter-sql
            p.tree-sitter-ssh_config
            p.tree-sitter-svelte
            p.tree-sitter-swift
            p.tree-sitter-sxhkdrc
            p.tree-sitter-tmux
            p.tree-sitter-toml
            p.tree-sitter-tsv
            p.tree-sitter-typescript
            p.tree-sitter-vim
            p.tree-sitter-vimdoc
            p.tree-sitter-vue
            p.tree-sitter-xml
            p.tree-sitter-yaml
            p.tree-sitter-zathurarc
            p.tree-sitter-yuck
            p.tree-sitter-zig
            p.tree-sitter-terraform
            p.tree-sitter-cuda
          ])
        );
        config = sourceLuaFile ./nvim-treesitter.lua;
      }

    ];
  };
}
