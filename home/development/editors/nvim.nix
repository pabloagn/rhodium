# home/development/editors/nvim.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  nvimConfigBaseDir = ./${categoryName};

  readNvimLuaFile = subPath: builtins.readFile (nvimConfigBaseDir + "/${subPath}");
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = subPath: toLua (readNvimLuaFile subPath);
in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions {
      appName = categoryName;
      hasDesktop = true;
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {

    programs.neovim = {
      enable = true;
      package = pkgs.neovim;
      withPython3 = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = readNvimLuaFile "options.lua";

      extraPackages = with pkgs; [
        neovim-remote
        lua-language-server
        nixd
        nil
        nixpkgs-fmt
        python3Packages.python-lsp-server
      ];

      plugins = with pkgs.vimPlugins; [
        { plugin = nvim-lspconfig; config = toLuaFile "plugin/lsp.lua"; }
        cmp-nixpkgs-maintainers
        { plugin = multicursors-nvim; }
        { plugin = comment-nvim; config = toLua "require(\"Comment\").setup()"; }
        { plugin = catppuccin-nvim; config = toLuaFile "plugin/catppuccin.lua"; }
        neodev-nvim
        { plugin = nvim-cmp; config = toLuaFile "plugin/cmp.lua"; }
        { plugin = telescope-nvim; config = toLuaFile "plugin/telescope.lua"; }
        { plugin = indent-blankline-nvim; config = toLuaFile "plugin/indent_blankline.lua"; }
        { plugin = nvim-colorizer-lua; config = toLuaFile "plugin/colorizer.lua"; }
        telescope-fzf-native-nvim
        cmp_luasnip
        cmp-nvim-lsp
        luasnip
        friendly-snippets
        fidget-nvim
        { plugin = lualine-nvim; config = toLuaFile "plugin/lualine/evil_lualine.lua"; }
        {
          plugin = (nvim-treesitter.withPlugins (p: [
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
          ]));
          config = toLuaFile "plugin/treesitter.lua";
        }
        vim-nix
        { plugin = vimtex; config = toLuaFile "plugin/vimtex.lua"; }
      ];
    };
  };
}
