{pkgs, ...}: {
  home.packages = with pkgs; [
    # Bash/Shell
    bash-language-server
    shfmt # Shell formatter
    shellcheck # Shell linter

    # C#/.NET/F#
    omnisharp-roslyn

    # C/C++
    clang-tools # Includes clang-format

    # CMake
    cmake-language-server
    cmake-format

    # Clojure
    clojure-lsp
    cljfmt # Formatter

    # Common Lisp
    sbcl # Common Lisp compiler

    # Crystal
    crystalline

    # CSS/HTML/JSON
    vscode-langservers-extracted # NOTE: Includes html, css, json, eslint

    # D language
    serve-d

    # # Dart/Flutter
    # dart
    # flutter

    # Deno (Alternative TypeScript runtime)
    deno

    # Dhall
    dhall-lsp-server

    # Docker
    nodePackages.dockerfile-language-server-nodejs

    # Elixir/Erlang
    elixir-ls
    erlang-ls

    # Elm
    elmPackages.elm-format
    elmPackages.elm-language-server

    # Emmet
    emmet-ls

    # F#
    fsautocomplete

    # Fennel
    fennel-ls

    # Fish Shell
    fish-lsp

    # Fortran
    fortls
    fprettify # Formatter

    # GLSL
    glslls

    # General
    nodePackages.prettier
    prettierd # NOTE: Prettier running as daemon

    # Go
    goimports-reviser
    gopls
    gofumpt

    # GraphQL (as nodePackage)
    nodePackages.graphql-language-service-cli

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
    biome

    # Just
    just-lsp

    # KDL
    kdlfmt

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
    nil # Original language server
    nixd # Latest language server
    nixpkgs-fmt # Formatter
    nixfmt-rfc-style # Official formatter
    alejandra # Opinionated formatter

    # OCaml
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat

    # Perl
    perlnavigator

    # PHP
    intelephense # NOTE: Alternative: phpactor

    # Prisma
    prisma-engines

    # Protocol Buffers
    buf

    # Python
    isort # Python import sorter
    pyright # Type checker
    ruff # Fast Python formatter/linter

    # R
    rPackages.styler
    rPackages.languageserver

    # Rust
    bacon # Background rust code checker
    cargo-info # Cargo subcommand to show crates info from crates.io
    rusty-man # Command-line viewer for documentation generated by rustdoc

    # SQL
    sqls # SQL language server
    sqlfluff # Formatter

    # Scala
    metals
    scalafmt # Formatter

    # Svelte
    svelte-language-server

    # Swift
    sourcekit-lsp

    # TOML
    taplo

    # Tailwind CSS
    tailwindcss-language-server

    # Terraform
    terraform-ls

    # Typst
    tinymist # Integrated language server for typst (includes formatters)

    # Vue
    vue-language-server

    # XML
    lemminx

    # YAML
    yaml-language-server

    # Zig
    zls # Zig Language Server
  ];
}
