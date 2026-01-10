{
  pkgs,
  sourceLuaFile,
}:
{
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
      #   plugin = image-nvim;
      #   config = sourceLuaFile "image-nvim.lua";
      # }
      {
        plugin = molten-nvim;
        config = sourceLuaFile "molten-nvim.lua";
      }

      # {
      #   plugin = lazydev-nvim;
      #   config = sourceLuaFile "lazydev-nvim.lua";
      # }

      vim-nix

      {
        plugin = vimtex;
        config = sourceLuaFile "vimtex.lua";
      }

      {
        plugin = render-markdown-nvim;
        config = sourceLuaFile "render-markdown-nvim.lua";
      }

      {
        plugin = typst-preview-nvim;
        config = sourceLuaFile "typst-preview-nvim.lua";
      }

      # Linting
      # {
      #   plugin = nvim-lint;
      #   config = sourceLuaFile "nvim-lint.lua";
      # }

      {
        plugin = vim-go;
        # config = sourceLuaFile "vim-go-nvim.lua";
      }

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

      # Support for Kmonad
      {
        plugin = kmonad-vim;
        # config = sourceLuaFile "kmonad-nvim.lua";
      }

      # Snippets
      friendly-snippets # Lua snippets
      luasnip # Lua snippets engine

      # Treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects

      {
        plugin = (
          nvim-treesitter.withPlugins (p: [
            p.tree-sitter-ada
            p.tree-sitter-agda
            p.tree-sitter-angular
            p.tree-sitter-apex
            p.tree-sitter-arduino
            p.tree-sitter-asm
            p.tree-sitter-astro
            p.tree-sitter-authzed
            p.tree-sitter-awk
            p.tree-sitter-bash
            p.tree-sitter-bass
            p.tree-sitter-beancount
            p.tree-sitter-bibtex
            p.tree-sitter-bicep
            p.tree-sitter-bitbake
            p.tree-sitter-blade
            p.tree-sitter-blueprint
            p.tree-sitter-bp
            p.tree-sitter-brightscript
            p.tree-sitter-c
            p.tree-sitter-c_sharp
            p.tree-sitter-caddy
            p.tree-sitter-cairo
            p.tree-sitter-capnp
            p.tree-sitter-chatito
            p.tree-sitter-circom
            p.tree-sitter-clojure
            p.tree-sitter-cmake
            p.tree-sitter-comment
            p.tree-sitter-commonlisp
            p.tree-sitter-cooklang
            p.tree-sitter-corn
            p.tree-sitter-cpon
            p.tree-sitter-cpp
            p.tree-sitter-css
            p.tree-sitter-csv
            p.tree-sitter-cuda
            p.tree-sitter-cue
            p.tree-sitter-cylc
            p.tree-sitter-d
            p.tree-sitter-dart
            p.tree-sitter-desktop
            p.tree-sitter-devicetree
            p.tree-sitter-dhall
            p.tree-sitter-diff
            p.tree-sitter-disassembly
            p.tree-sitter-djot
            p.tree-sitter-dockerfile
            p.tree-sitter-dot
            p.tree-sitter-doxygen
            p.tree-sitter-dtd
            p.tree-sitter-earthfile
            p.tree-sitter-ebnf
            p.tree-sitter-editorconfig
            p.tree-sitter-eds
            p.tree-sitter-eex
            p.tree-sitter-elixir
            p.tree-sitter-elisp
            p.tree-sitter-elm
            p.tree-sitter-elsa
            p.tree-sitter-elvish
            p.tree-sitter-embedded_template
            p.tree-sitter-enforce
            p.tree-sitter-erlang
            p.tree-sitter-facility
            p.tree-sitter-faust
            p.tree-sitter-fennel
            p.tree-sitter-fidl
            p.tree-sitter-firrtl
            p.tree-sitter-fish
            p.tree-sitter-foam
            p.tree-sitter-forth
            p.tree-sitter-fortran
            p.tree-sitter-fsh
            p.tree-sitter-fsharp
            p.tree-sitter-func
            p.tree-sitter-fusion
            p.tree-sitter-gap
            p.tree-sitter-gaptst
            p.tree-sitter-gdscript
            p.tree-sitter-gdshader
            p.tree-sitter-git_config
            p.tree-sitter-git_rebase
            p.tree-sitter-gitattributes
            p.tree-sitter-gitcommit
            p.tree-sitter-gitignore
            p.tree-sitter-gleam
            p.tree-sitter-glimmer
            p.tree-sitter-glimmer_javascript
            p.tree-sitter-glimmer_typescript
            p.tree-sitter-glsl
            p.tree-sitter-gn
            p.tree-sitter-gnuplot
            p.tree-sitter-go
            p.tree-sitter-goctl
            p.tree-sitter-godot_resource
            p.tree-sitter-gomod
            p.tree-sitter-gosum
            p.tree-sitter-gotmpl
            p.tree-sitter-gowork
            p.tree-sitter-gpg
            p.tree-sitter-graphql
            p.tree-sitter-gren
            p.tree-sitter-groovy
            p.tree-sitter-gstlaunch
            p.tree-sitter-hack
            p.tree-sitter-hare
            p.tree-sitter-haskell
            p.tree-sitter-haskell_persistent
            p.tree-sitter-hcl
            p.tree-sitter-heex
            p.tree-sitter-helm
            p.tree-sitter-hjson
            p.tree-sitter-hlsl
            p.tree-sitter-hlsplaylist
            p.tree-sitter-hocon
            p.tree-sitter-hoon
            p.tree-sitter-html
            p.tree-sitter-htmldjango
            p.tree-sitter-http
            p.tree-sitter-hurl
            p.tree-sitter-hyprlang
            p.tree-sitter-idl
            p.tree-sitter-idris
            p.tree-sitter-ini
            p.tree-sitter-inko
            p.tree-sitter-ispc
            p.tree-sitter-janet_simple
            p.tree-sitter-java
            p.tree-sitter-javadoc
            p.tree-sitter-javascript
            p.tree-sitter-jinja
            p.tree-sitter-jinja_inline
            p.tree-sitter-jq
            p.tree-sitter-jsdoc
            p.tree-sitter-json
            p.tree-sitter-json5
            p.tree-sitter-jsonc
            p.tree-sitter-jsonnet
            p.tree-sitter-julia
            p.tree-sitter-just
            p.tree-sitter-kcl
            p.tree-sitter-kconfig
            p.tree-sitter-kdl
            p.tree-sitter-kotlin
            p.tree-sitter-koto
            p.tree-sitter-kusto
            p.tree-sitter-lalrpop
            p.tree-sitter-latex
            p.tree-sitter-ledger
            p.tree-sitter-leo
            p.tree-sitter-linkerscript
            p.tree-sitter-liquid
            p.tree-sitter-liquidsoap
            p.tree-sitter-llvm
            p.tree-sitter-lua
            p.tree-sitter-luadoc
            p.tree-sitter-luap
            p.tree-sitter-luau
            p.tree-sitter-m68k
            p.tree-sitter-make
            p.tree-sitter-markdown
            p.tree-sitter-markdown_inline
            p.tree-sitter-matlab
            p.tree-sitter-menhir
            p.tree-sitter-mermaid
            p.tree-sitter-meson
            p.tree-sitter-mlir
            p.tree-sitter-muttrc
            p.tree-sitter-nasm
            p.tree-sitter-nginx
            p.tree-sitter-nickel
            p.tree-sitter-nim
            p.tree-sitter-nim_format_string
            p.tree-sitter-ninja
            p.tree-sitter-nix
            p.tree-sitter-norg
            p.tree-sitter-nqc
            p.tree-sitter-nu
            p.tree-sitter-objc
            p.tree-sitter-objdump
            p.tree-sitter-ocaml
            p.tree-sitter-ocaml_interface
            p.tree-sitter-ocamllex
            p.tree-sitter-odin
            p.tree-sitter-pascal
            p.tree-sitter-passwd
            p.tree-sitter-pem
            p.tree-sitter-perl
            p.tree-sitter-php
            p.tree-sitter-php_only
            p.tree-sitter-phpdoc
            p.tree-sitter-pioasm
            p.tree-sitter-po
            p.tree-sitter-pod
            p.tree-sitter-poe_filter
            p.tree-sitter-pony
            p.tree-sitter-powershell
            p.tree-sitter-printf
            p.tree-sitter-prisma
            p.tree-sitter-problog
            p.tree-sitter-prolog
            p.tree-sitter-promql
            p.tree-sitter-properties
            p.tree-sitter-proto
            p.tree-sitter-prql
            p.tree-sitter-psv
            p.tree-sitter-pug
            p.tree-sitter-puppet
            p.tree-sitter-purescript
            p.tree-sitter-pymanifest
            p.tree-sitter-python
            p.tree-sitter-ql
            p.tree-sitter-qmldir
            p.tree-sitter-qmljs
            p.tree-sitter-query
            p.tree-sitter-r
            p.tree-sitter-racket
            p.tree-sitter-ralph
            p.tree-sitter-rasi
            p.tree-sitter-razor
            p.tree-sitter-rbs
            p.tree-sitter-re2c
            p.tree-sitter-readline
            p.tree-sitter-regex
            p.tree-sitter-rego
            p.tree-sitter-requirements
            p.tree-sitter-rescript
            p.tree-sitter-rnoweb
            p.tree-sitter-robot
            p.tree-sitter-robots
            p.tree-sitter-roc
            p.tree-sitter-ron
            p.tree-sitter-rst
            p.tree-sitter-ruby
            p.tree-sitter-runescript
            p.tree-sitter-rust
            p.tree-sitter-scala
            p.tree-sitter-scfg
            p.tree-sitter-scheme
            p.tree-sitter-scss
            p.tree-sitter-sflog
            p.tree-sitter-slang
            p.tree-sitter-slim
            p.tree-sitter-slint
            p.tree-sitter-smali
            p.tree-sitter-smithy
            p.tree-sitter-snakemake
            p.tree-sitter-solidity
            p.tree-sitter-soql
            p.tree-sitter-sosl
            p.tree-sitter-sourcepawn
            p.tree-sitter-sparql
            p.tree-sitter-sql
            p.tree-sitter-squirrel
            p.tree-sitter-ssh_config
            p.tree-sitter-starlark
            p.tree-sitter-strace
            p.tree-sitter-styled
            p.tree-sitter-supercollider
            p.tree-sitter-superhtml
            p.tree-sitter-surface
            p.tree-sitter-svelte
            p.tree-sitter-sway
            p.tree-sitter-swift
            p.tree-sitter-sxhkdrc
            p.tree-sitter-systemtap
            p.tree-sitter-t32
            p.tree-sitter-tablegen
            p.tree-sitter-tact
            p.tree-sitter-tcl
            p.tree-sitter-teal
            p.tree-sitter-templ
            p.tree-sitter-tera
            p.tree-sitter-terraform
            p.tree-sitter-textproto
            p.tree-sitter-thrift
            p.tree-sitter-tiger
            p.tree-sitter-tlaplus
            p.tree-sitter-tmux
            p.tree-sitter-todotxt
            p.tree-sitter-toml
            p.tree-sitter-tsv
            p.tree-sitter-tsx
            p.tree-sitter-turtle
            p.tree-sitter-twig
            p.tree-sitter-typescript
            p.tree-sitter-typespec
            p.tree-sitter-typoscript
            p.tree-sitter-typst
            p.tree-sitter-udev
            p.tree-sitter-ungrammar
            p.tree-sitter-unison
            p.tree-sitter-usd
            p.tree-sitter-uxntal
            p.tree-sitter-v
            p.tree-sitter-vala
            p.tree-sitter-vento
            p.tree-sitter-verilog
            p.tree-sitter-vhdl
            p.tree-sitter-vhs
            p.tree-sitter-vim
            p.tree-sitter-vimdoc
            p.tree-sitter-vrl
            p.tree-sitter-vue
            p.tree-sitter-wgsl
            p.tree-sitter-wgsl_bevy
            p.tree-sitter-wing
            p.tree-sitter-wit
            p.tree-sitter-xcompose
            p.tree-sitter-xml
            p.tree-sitter-xresources
            p.tree-sitter-yaml
            p.tree-sitter-yang
            p.tree-sitter-yuck
            p.tree-sitter-zathurarc
            p.tree-sitter-zig
            p.tree-sitter-ziggy
            p.tree-sitter-ziggy_schema
          ])
        );
        config = sourceLuaFile "nvim-treesitter.lua";
      }
    ];
  };
}
