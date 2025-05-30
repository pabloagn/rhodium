{ pkgs, ... }:
{
  home.packages = with pkgs; [

    # Bash/Shell
    bash-language-server
    shfmt # Shell formatter
    shellcheck # Shell linter

    # C#/.NET/F#
    omnisharp-roslyn

    # C/C++
    clang-tools # includes clang-format
    # clangd

    # Clojure
    clojure-lsp

    # Common Lisp
    sbcl # Common Lisp compiler

    # CSS/HTML/JSON
    vscode-langservers-extracted # Includes html, css, json, eslint

    # Elixir/Erlang
    elixir-ls
    erlang-ls

    # Elm
    elmPackages.elm-format
    elmPackages.elm-language-server

    # General
    nodePackages.prettier
    prettierd # Prettier running as daemon

    # Go
    goimports-reviser
    gopls

    # Haskell
    haskell-language-server
    haskellPackages.fourmolu # or haskellPackages.ormolu

    # Java
    google-java-format
    jdt-language-server # Eclipse JDT LS

    # JavaScript/TypeScript/React.js/Next.js
    nodePackages.eslint
    nodePackages.npm
    nodePackages.prettier
    nodePackages.typescript-language-server

    # Kotlin
    kotlin-language-server

    # LaTeX
    texlab
    texlivePackages.latexindent

    # Lua
    lua-language-server
    stylua

    # Markdown
    markdown-oxide
    marksman

    # Nix
    nil
    nixd
    nixpkgs-fmt

    # OCaml
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat

    # Perl
    perlnavigator

    # PHP
    intelephense
    # Alternative: phpactor

    # Python
    isort # Python import sorter
    pyright # Type checker
    ruff # Fast Python formatter/linter

    # Scala
    metals

    # SQL
    sqls # SQL language server

    # Swift
    sourcekit-lsp

    # Tailwind CSS
    tailwindcss-language-server

    # TOML
    taplo

    # YAML
    yaml-language-server

    # Zig
    zls # Zig Language Server
  ];
}
