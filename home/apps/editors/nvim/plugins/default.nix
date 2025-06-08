{ pkgs, ... }:

let
  # toLua = str: "lua << EOF\n${str}\nEOF\n";
  sourceLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [

      {
        plugin = mini-nvim;
        config = sourceLuaFile ./mini-nvim.lua;
      }

      {
        plugin = ts-comments-nvim;
        config = sourceLuaFile ./ts-comments-nvim.lua;
      }

      {
        plugin = lazydev-nvim;
        config = sourceLuaFile ./lazydev-nvim.lua;
      }

      {
        plugin = bufferline-nvim;
        config = sourceLuaFile ./bufferline-nvim.lua;
      }

      {
        plugin = yazi-nvim;
        config = sourceLuaFile ./yazi-nvim.lua;
      }

      {
        plugin = flash-nvim;
        config = sourceLuaFile ./flash-nvim.lua;
      }

      {
        plugin = refactoring-nvim;
        config = sourceLuaFile ./refactoring-nvim.lua;
      }

      {
        plugin = plenary-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = alpha-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = dashboard-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = telescope-nvim;
        config = sourceLuaFile ./telescope.lua;
      }

      telescope-fzf-native-nvim

      {
        plugin = none-ls-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = crates-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = neoconf-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = edgy-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = nvim-treesitter-context;
        config = sourceLuaFile ./;
      }

      {
        plugin = nvim-treesitter-textobjects;
        config = sourceLuaFile ./;
      }

      {
        plugin = octo-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = which-key-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = project-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = gitsigns-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = trouble-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = todo-comments-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = conform-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = nvim-lint;
        config = sourceLuaFile ./;
      }

      {
        plugin = nvim-lspconfig;
        config = sourceLuaFile ./lsp.lua;
      }

      {
        plugin = noice-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = nui-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = snacks-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = persistence-nvim;
        config = sourceLuaFile ./;
      }


      {
        plugin = luasnip;
        config = sourceLuaFile ./;
      }

      {
        plugin = lualine-nvim;
        config = sourceLuaFile ./lualine/evil_lualine.lua;
      }

      # cmp
      # ---------------------------------------------
      {
        plugin = nvim-cmp;
        config = sourceLuaFile ./cmp.lua;
      }

      {
        plugin = blink-cmp;
        config = sourceLuaFile ./;
      }

      cmp-dictionary
      cmp-latex-symbols
      cmp-nvim-lsp
      cmp-path # Path completion
      cmp-nixpkgs-maintainers


      vim-nix

      {
        plugin = neogen;
        config = sourceLuaFile ./;
      }

      {
        plugin = nvim-dap;
        config = sourceLuaFile ./;
      }

      {
        plugin = aerial-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = fzf-vim;
        config = sourceLuaFile ./;
      }

      {
        plugin = harpoon2;
        config = sourceLuaFile ./;
      }

      {
        plugin = vim-illuminate;
        config = sourceLuaFile ./;
      }

      {
        plugin = leap-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = neo-tree-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = outline-nvim;
        config = sourceLuaFile ./;
      }

      {
        plugin = multicursors-nvim;
        config = sourceLuaFile ./;
      }

      # {
      #   plugin = comment;
      #   config = sourceLuaFile ./comment-nvim.lua;
      # }

      {
        plugin = catppuccin-nvim;
        config = sourceLuaFile ./catppuccin.lua;
      }

      {
        plugin = indent-blankline-nvim;
        config = sourceLuaFile ./indent_blankline.lua;
      }

      {
        plugin = nvim-colorizer-lua;
        config = sourceLuaFile ./colorizer.lua;
      }

      # friendly-snippets
      fidget-nvim

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
            p.tree-sitter-java
            p.tree-sitter-javascript
            p.tree-sitter-json
            p.tree-sitter-julia
            p.tree-sitter-kotlin
            p.tree-sitter-latex
            p.tree-sitter-lua
            p.tree-sitter-luadoc
            p.tree-sitter-markdown
            p.tree-sitter-markdown-inline
            p.tree-sitter-nix
            p.tree-sitter-ocaml
            p.tree-sitter-perl
            p.tree-sitter-php
            p.tree-sitter-python
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
          ])
        );
        config = sourceLuaFile ./treesitter.lua;
      }


      {
        plugin = vimtex;
        config = sourceLuaFile ./vimtex.lua;
      }
    ];
  };
}
