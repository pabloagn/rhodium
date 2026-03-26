{ ... }:
{
  programs.helix.languages = {

    # ── Language Server Definitions ──────────────────────────────────────

    # NOTE: Server names MUST match what Helix's built-in languages.toml
    # expects, otherwise the LSP won't activate for that language.

    # Bash
    language-server.bash-language-server = {
      command = "bash-language-server";
      args = [ "start" ];
    };

    # C / C++
    language-server.clangd = {
      command = "clangd";
    };

    # C#
    language-server.omnisharp = {
      command = "omnisharp";
      args = [ "-lsp" ];
    };

    # Clojure
    language-server.clojure-lsp = {
      command = "clojure-lsp";
    };

    # CMake
    language-server.cmake-language-server = {
      command = "cmake-language-server";
    };

    # Crystal
    language-server.crystalline = {
      command = "crystalline";
    };

    # CSS
    language-server.vscode-css-language-server = {
      command = "vscode-css-language-server";
      args = [ "--stdio" ];
      config.provideFormatter = true;
    };

    # D
    language-server.serve-d = {
      command = "serve-d";
    };

    # Dhall
    language-server.dhall-lsp-server = {
      command = "dhall-lsp-server";
    };

    # Docker
    language-server.docker-langserver = {
      command = "docker-langserver";
      args = [ "--stdio" ];
    };

    # Elixir
    language-server.elixir-ls = {
      command = "elixir-ls";
    };

    # Elm
    language-server.elm-language-server = {
      command = "elm-language-server";
    };

    # Emmet (HTML/CSS expansion)
    language-server.emmet-lsp = {
      command = "emmet-language-server";
      args = [ "--stdio" ];
    };

    # Fish
    language-server.fish-lsp = {
      command = "fish-lsp";
      args = [ "start" ];
    };

    # Fortran
    language-server.fortls = {
      command = "fortls";
    };

    # F#
    language-server.fsautocomplete = {
      command = "fsautocomplete";
      args = [ "--adaptive-lsp-server-enabled" ];
    };

    # Gleam
    language-server.gleam = {
      command = "gleam";
      args = [ "lsp" ];
    };

    # Go
    language-server.gopls = {
      command = "gopls";
      config.hints = {
        assignVariableTypes = true;
        compositeLiteralFields = true;
        compositeLiteralTypes = true;
        constantValues = true;
        functionTypeParameters = true;
        parameterNames = true;
        rangeVariableTypes = true;
      };
    };

    # GraphQL
    language-server.graphql-language-service = {
      command = "graphql-lsp";
      args = [
        "server"
        "-m"
        "stream"
      ];
    };

    # Haskell
    language-server.haskell-language-server = {
      command = "haskell-language-server-wrapper";
      args = [ "--lsp" ];
    };

    # HTML
    language-server.vscode-html-language-server = {
      command = "vscode-html-language-server";
      args = [ "--stdio" ];
      config.provideFormatter = true;
    };

    # Java
    language-server.jdtls = {
      command = "jdtls";
    };

    # Jinja
    language-server.jinja-lsp = {
      command = "jinja-lsp";
    };

    # JSON
    language-server.vscode-json-language-server = {
      command = "vscode-json-language-server";
      args = [ "--stdio" ];
      config = {
        provideFormatter = true;
        json.validate.enable = true;
      };
    };

    # Julia
    language-server.julia-lsp = {
      command = "julia";
      args = [
        "--startup-file=no"
        "--history-file=no"
        "-e"
        "using LanguageServer; runserver()"
      ];
    };

    # Kotlin
    language-server.kotlin-language-server = {
      command = "kotlin-language-server";
    };

    # LaTeX
    language-server.texlab = {
      command = "texlab";
    };

    # Lua (NOTE: was "lua-ls" which didn't match Helix's built-in name)
    language-server.lua-language-server = {
      command = "lua-language-server";
    };

    # Markdown
    language-server.marksman = {
      command = "marksman";
      args = [ "server" ];
    };

    # Nix
    language-server.nil = {
      command = "nil";
      config.nil.formatting.command = [ "nixfmt" ];
    };

    language-server.nixd = {
      command = "nixd";
    };

    # Nushell
    language-server.nushell = {
      command = "nu";
      args = [ "--lsp" ];
    };

    # OCaml (NOTE: was "ocaml-lsp" which didn't match Helix's built-in name)
    language-server.ocamllsp = {
      command = "ocamllsp";
    };

    # Odin
    language-server.ols = {
      command = "ols";
    };

    # Perl
    language-server.perlnavigator = {
      command = "perlnavigator";
      args = [ "--stdio" ];
    };

    # PHP
    language-server.intelephense = {
      command = "intelephense";
      args = [ "--stdio" ];
    };

    # Prisma
    language-server.prisma-language-server = {
      command = "prisma-language-server";
      args = [ "--stdio" ];
    };

    # Protocol Buffers
    language-server.bufls = {
      command = "buf";
      args = [
        "beta"
        "lsp"
      ];
    };

    # Python (NOTE: was "pyright-extended" which didn't match any built-in name)
    language-server.pyright = {
      command = "pyright-langserver";
      args = [ "--stdio" ];
      config.python.analysis = {
        typeCheckingMode = "basic";
        autoImportCompletions = true;
      };
    };

    language-server.ruff = {
      command = "ruff";
      args = [ "server" ];
    };

    # R
    language-server.r-language-server = {
      command = "R";
      args = [
        "--slave"
        "-e"
        "languageserver::run()"
      ];
    };

    # Rust
    language-server.rust-analyzer = {
      command = "rust-analyzer";
    };

    # Scala
    language-server.metals = {
      command = "metals";
    };

    # SQL
    language-server.sqls = {
      command = "sqls";
    };

    # Svelte
    language-server.svelteserver = {
      command = "svelteserver";
      args = [ "--stdio" ];
    };

    # Swift
    language-server.sourcekit-lsp = {
      command = "sourcekit-lsp";
    };

    # Tailwind CSS (NOTE: was "tailwindcss-language-server" which didn't match Helix's built-in name)
    language-server.tailwindcss-ls = {
      command = "tailwindcss-language-server";
      args = [ "--stdio" ];
    };

    # Terraform
    language-server.terraform-ls = {
      command = "terraform-ls";
      args = [ "serve" ];
    };

    # TOML
    language-server.taplo = {
      command = "taplo";
      args = [
        "lsp"
        "stdio"
      ];
    };

    # Typst
    language-server.tinymist = {
      command = "tinymist";
    };

    # TypeScript / JavaScript
    language-server.typescript-language-server = {
      command = "typescript-language-server";
      args = [ "--stdio" ];
    };

    # Vue
    language-server.vue-language-server = {
      command = "vue-language-server";
      args = [ "--stdio" ];
    };

    # XML
    language-server.lemminx = {
      command = "lemminx";
    };

    # YAML
    language-server.yaml-language-server = {
      command = "yaml-language-server";
      args = [ "--stdio" ];
      config.yaml = {
        validate = true;
        completion = true;
      };
    };

    # Zig
    language-server.zls = {
      command = "zls";
    };

    # ── Language Configurations ──────────────────────────────────────────
    # Override built-in defaults to assign formatters, multi-server setups,
    # and file-type associations missing from Helix's defaults.

    language = [

      # ── Bash / Shell ───────────────────────────────────────────────────
      {
        name = "bash";
        language-servers = [ "bash-language-server" ];
        formatter = {
          command = "shfmt";
        };
        auto-format = true;
      }

      # ── C ──────────────────────────────────────────────────────────────
      {
        name = "c";
        language-servers = [ "clangd" ];
        formatter = {
          command = "clang-format";
        };
        auto-format = true;
      }

      # ── C++ ────────────────────────────────────────────────────────────
      {
        name = "cpp";
        language-servers = [ "clangd" ];
        formatter = {
          command = "clang-format";
        };
        auto-format = true;
      }

      # ── C# ────────────────────────────────────────────────────────────
      {
        name = "c-sharp";
        language-servers = [ "omnisharp" ];
        auto-format = true;
      }

      # ── Clojure ────────────────────────────────────────────────────────
      {
        name = "clojure";
        language-servers = [ "clojure-lsp" ];
        auto-format = true;
      }

      # ── CMake ──────────────────────────────────────────────────────────
      {
        name = "cmake";
        language-servers = [ "cmake-language-server" ];
        auto-format = true;
      }

      # ── Crystal ────────────────────────────────────────────────────────
      {
        name = "crystal";
        language-servers = [ "crystalline" ];
        auto-format = true;
      }

      # ── CSS ────────────────────────────────────────────────────────────
      {
        name = "css";
        language-servers = [
          "vscode-css-language-server"
          "tailwindcss-ls"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.css"
          ];
        };
        auto-format = true;
      }

      # ── D ──────────────────────────────────────────────────────────────
      {
        name = "d";
        language-servers = [ "serve-d" ];
        auto-format = true;
      }

      # ── Dhall ──────────────────────────────────────────────────────────
      {
        name = "dhall";
        language-servers = [ "dhall-lsp-server" ];
        formatter = {
          command = "dhall";
          args = [ "format" ];
        };
        auto-format = true;
      }

      # ── Docker ─────────────────────────────────────────────────────────
      {
        name = "dockerfile";
        language-servers = [ "docker-langserver" ];
      }

      # ── Elixir ─────────────────────────────────────────────────────────
      {
        name = "elixir";
        language-servers = [ "elixir-ls" ];
        formatter = {
          command = "mix";
          args = [
            "format"
            "-"
          ];
        };
        auto-format = true;
      }

      # ── Elm ────────────────────────────────────────────────────────────
      {
        name = "elm";
        language-servers = [ "elm-language-server" ];
        auto-format = true;
      }

      # ── Env / Dotenv (.env file highlighting) ──────────────────────────
      {
        name = "env";
        file-types = [
          {
            glob = ".env";
          }
          {
            glob = ".env.*";
          }
        ];
      }

      # ── Fish ───────────────────────────────────────────────────────────
      {
        name = "fish";
        language-servers = [ "fish-lsp" ];
        formatter = {
          command = "fish_indent";
        };
        auto-format = true;
      }

      # ── Fortran ────────────────────────────────────────────────────────
      {
        name = "fortran";
        language-servers = [ "fortls" ];
        formatter = {
          command = "fprettify";
        };
        auto-format = true;
      }

      # ── F# ────────────────────────────────────────────────────────────
      {
        name = "fsharp";
        language-servers = [ "fsautocomplete" ];
        auto-format = true;
      }

      # ── Gleam ──────────────────────────────────────────────────────────
      {
        name = "gleam";
        language-servers = [ "gleam" ];
        auto-format = true;
      }

      # ── Go ─────────────────────────────────────────────────────────────
      {
        name = "go";
        language-servers = [ "gopls" ];
        formatter = {
          command = "gofumpt";
        };
        auto-format = true;
      }

      # ── GraphQL ────────────────────────────────────────────────────────
      {
        name = "graphql";
        language-servers = [ "graphql-language-service" ];
      }

      # ── Haskell ────────────────────────────────────────────────────────
      {
        name = "haskell";
        language-servers = [ "haskell-language-server" ];
        auto-format = true;
      }

      # ── HCL / Terraform ───────────────────────────────────────────────
      {
        name = "hcl";
        language-servers = [ "terraform-ls" ];
        auto-format = true;
      }

      # ── HTML ───────────────────────────────────────────────────────────
      {
        name = "html";
        language-servers = [
          "vscode-html-language-server"
          "tailwindcss-ls"
          "emmet-lsp"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.html"
          ];
        };
        auto-format = true;
      }

      # ── Java ───────────────────────────────────────────────────────────
      {
        name = "java";
        language-servers = [ "jdtls" ];
        auto-format = true;
      }

      # ── JavaScript ────────────────────────────────────────────────────
      {
        name = "javascript";
        language-servers = [
          "typescript-language-server"
          "tailwindcss-ls"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.js"
          ];
        };
        auto-format = true;
      }

      # ── JSON ───────────────────────────────────────────────────────────
      {
        name = "json";
        language-servers = [ "vscode-json-language-server" ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.json"
          ];
        };
        auto-format = true;
      }

      # ── JSONC ──────────────────────────────────────────────────────────
      {
        name = "jsonc";
        language-servers = [ "vscode-json-language-server" ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.jsonc"
          ];
        };
        auto-format = true;
      }

      # ── JSX ────────────────────────────────────────────────────────────
      {
        name = "jsx";
        language-servers = [
          "typescript-language-server"
          "tailwindcss-ls"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.jsx"
          ];
        };
        auto-format = true;
      }

      # ── Julia ──────────────────────────────────────────────────────────
      {
        name = "julia";
        language-servers = [ "julia-lsp" ];
        auto-format = true;
      }

      # ── Kotlin ─────────────────────────────────────────────────────────
      {
        name = "kotlin";
        language-servers = [ "kotlin-language-server" ];
        auto-format = true;
      }

      # ── LaTeX ──────────────────────────────────────────────────────────
      {
        name = "latex";
        language-servers = [ "texlab" ];
        auto-format = true;
      }

      # ── Lua ────────────────────────────────────────────────────────────
      {
        name = "lua";
        language-servers = [ "lua-language-server" ];
        formatter = {
          command = "stylua";
          args = [ "-" ];
        };
        auto-format = true;
      }

      # ── Markdown ───────────────────────────────────────────────────────
      {
        name = "markdown";
        language-servers = [ "marksman" ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.md"
          ];
        };
        auto-format = true;
        soft-wrap.enable = true;
      }

      # ── Nix ────────────────────────────────────────────────────────────
      {
        name = "nix";
        language-servers = [
          "nixd"
          "nil"
        ];
        formatter = {
          command = "nixfmt";
        };
        auto-format = true;
      }

      # ── Nushell ────────────────────────────────────────────────────────
      {
        name = "nu";
        language-servers = [ "nushell" ];
      }

      # ── OCaml ──────────────────────────────────────────────────────────
      {
        name = "ocaml";
        language-servers = [ "ocamllsp" ];
        auto-format = true;
      }

      # ── Odin ───────────────────────────────────────────────────────────
      {
        name = "odin";
        language-servers = [ "ols" ];
      }

      # ── Perl ───────────────────────────────────────────────────────────
      {
        name = "perl";
        language-servers = [ "perlnavigator" ];
      }

      # ── PHP ────────────────────────────────────────────────────────────
      {
        name = "php";
        language-servers = [ "intelephense" ];
        auto-format = true;
      }

      # ── Prisma ─────────────────────────────────────────────────────────
      {
        name = "prisma";
        language-servers = [ "prisma-language-server" ];
        auto-format = true;
      }

      # ── Protobuf ───────────────────────────────────────────────────────
      {
        name = "protobuf";
        language-servers = [ "bufls" ];
      }

      # ── Python ─────────────────────────────────────────────────────────
      {
        name = "python";
        language-servers = [
          {
            name = "pyright";
            except-features = [ "format" ];
          }
          {
            name = "ruff";
            only-features = [
              "format"
              "diagnostics"
            ];
          }
        ];
        formatter = {
          command = "ruff";
          args = [
            "format"
            "-"
          ];
        };
        auto-format = true;
      }

      # ── R ──────────────────────────────────────────────────────────────
      {
        name = "r";
        language-servers = [ "r-language-server" ];
        auto-format = true;
      }

      # ── Rust ───────────────────────────────────────────────────────────
      {
        name = "rust";
        language-servers = [ "rust-analyzer" ];
        auto-format = true;
      }

      # ── Scala ──────────────────────────────────────────────────────────
      {
        name = "scala";
        language-servers = [ "metals" ];
        auto-format = true;
      }

      # ── SCSS ───────────────────────────────────────────────────────────
      {
        name = "scss";
        language-servers = [
          "vscode-css-language-server"
          "tailwindcss-ls"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.scss"
          ];
        };
        auto-format = true;
      }

      # ── SQL ────────────────────────────────────────────────────────────
      {
        name = "sql";
        language-servers = [ "sqls" ];
      }

      # ── Svelte ─────────────────────────────────────────────────────────
      {
        name = "svelte";
        language-servers = [
          "svelteserver"
          "tailwindcss-ls"
        ];
        auto-format = true;
      }

      # ── Swift ──────────────────────────────────────────────────────────
      {
        name = "swift";
        language-servers = [ "sourcekit-lsp" ];
        auto-format = true;
      }

      # ── Terraform Variables ────────────────────────────────────────────
      {
        name = "tfvars";
        language-servers = [ "terraform-ls" ];
        auto-format = true;
      }

      # ── TOML ───────────────────────────────────────────────────────────
      {
        name = "toml";
        language-servers = [ "taplo" ];
        auto-format = true;
      }

      # ── TSX ────────────────────────────────────────────────────────────
      {
        name = "tsx";
        language-servers = [
          "typescript-language-server"
          "tailwindcss-ls"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.tsx"
          ];
        };
        auto-format = true;
      }

      # ── TypeScript ────────────────────────────────────────────────────
      {
        name = "typescript";
        language-servers = [
          "typescript-language-server"
          "tailwindcss-ls"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.ts"
          ];
        };
        auto-format = true;
      }

      # ── Typst ──────────────────────────────────────────────────────────
      {
        name = "typst";
        language-servers = [ "tinymist" ];
        formatter = {
          command = "typstfmt";
        };
        auto-format = true;
      }

      # ── Vue ────────────────────────────────────────────────────────────
      {
        name = "vue";
        language-servers = [
          "vue-language-server"
          "tailwindcss-ls"
        ];
        auto-format = true;
      }

      # ── XML ────────────────────────────────────────────────────────────
      {
        name = "xml";
        language-servers = [ "lemminx" ];
        auto-format = true;
      }

      # ── YAML ───────────────────────────────────────────────────────────
      {
        name = "yaml";
        language-servers = [ "yaml-language-server" ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.yaml"
          ];
        };
        auto-format = true;
      }

      # ── Zig ────────────────────────────────────────────────────────────
      {
        name = "zig";
        language-servers = [ "zls" ];
        auto-format = true;
      }
    ];
  };
}
