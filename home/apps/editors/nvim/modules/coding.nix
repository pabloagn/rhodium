{
  pkgs,
  sourceLuaFile,
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Completion
      {
        plugin = nvim-cmp; # Completion engine
        config = sourceLuaFile "nvim-cmp.lua";
      }

      # {
      #   plugin = blink-cmp;
      #   config = sourceLuaFile "blink-cmp.lua";
      # }

      cmp-buffer
      cmp-dictionary
      cmp-latex-symbols
      cmp-nixpkgs-maintainers
      cmp-nvim-lsp
      cmp-path # Path completion

      # Comments
      {
        plugin = comment-nvim;
        config = sourceLuaFile "comment-nvim.lua";
      }

      # Debugging
      # {
      #   plugin = nvim-dap;
      #   config = sourceLuaFile "nvim-dap.lua";
      # }

      # Languages
      # {
      #   plugin = crates-nvim;
      #   config = sourceLuaFile "crates-nvim.lua";
      # }

      # {
      #   plugin = lazydev-nvim;
      #   config = sourceLuaFile "lazydev-nvim.lua";
      # }

      vim-nix

      {
        plugin = vimtex;
        config = sourceLuaFile "vimtex.lua";
      }

      # Linting
      # {
      #   plugin = nvim-lint;
      #   config = sourceLuaFile "nvim-lint.lua";
      # }

      # Movement
      {
        plugin = multicursors-nvim;
        config = sourceLuaFile "multicursors-nvim.lua";
      }

      # Refactoring
      # {
      #   plugin = neogen;
      #   config = sourceLuaFile "neogen.lua";
      # }

      # {
      #   plugin = refactoring-nvim;
      #   config = sourceLuaFile "refactoring-nvim.lua";
      # }

      # Snippets
      friendly-snippets # Lua snippets
      luasnip # Lua snippets engine

      # Treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects

      {
        plugin = (
          nvim-treesitter.withPlugins (p: [
            p.tree-sitter-bash
            p.tree-sitter-c
            p.tree-sitter-clojure
            p.tree-sitter-commonlisp
            p.tree-sitter-css
            p.tree-sitter-csv
            p.tree-sitter-cuda
            p.tree-sitter-dart
            p.tree-sitter-dockerfile
            p.tree-sitter-elixir
            p.tree-sitter-elisp
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
            p.tree-sitter-terraform
            p.tree-sitter-tmux
            p.tree-sitter-toml
            p.tree-sitter-tsv
            p.tree-sitter-tsx
            p.tree-sitter-typescript
            p.tree-sitter-typst
            p.tree-sitter-vim
            p.tree-sitter-vimdoc
            p.tree-sitter-vue
            p.tree-sitter-xml
            p.tree-sitter-yaml
            p.tree-sitter-yuck
            p.tree-sitter-zathurarc
            p.tree-sitter-zig
            p.tree-sitter-fennel
          ])
        );
        config = sourceLuaFile "nvim-treesitter.lua";
      }
    ];
  };
}
