{ config, ... }:

{
  programs.helix.settings.languages =
    {
      # Generals
      indent = {
        tab-width = 4;
        unit = "    ";
      };

      # Language servers
      language-server.rust-analyzer = {
        command = "rust-analyzer";
      };
      language-server.metals = {
        command = "metals";
      };
      language-server.gopls = {
        command = "gopls";
      };
      language-server."pyright-extended" = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
      };
      language-server.texlab = {
        command = "texlab";
      };
      language-server.nil = {
        command = "nil";
      };
      language-server."lua-ls" = {
        command = "lua-language-server";
      };
      language-server.taplo = {
        command = "taplo";
        args = [ "lsp" "stdio" ];
      };
      language-server."yaml-language-server" = {
        command = "yaml-language-server";
        args = [ "--stdio" ];
      };
      language-server."typescript-language-server" = {
        command = "typescript-language-server";
        args = [ "--stdio" ];
      };
      language-server."tailwindcss-language-server" = {
        command = "tailwindcss-language-server";
        args = [ "--stdio" ];
      };
      language-server."vscode-html-language-server" = {
        command = "vscode-html-language-server";
        args = [ "--stdio" ];
      };
      language-server."vscode-css-language-server" = {
        command = "vscode-css-language-server";
        args = [ "--stdio" ];
      };
      language-server.bash-language-server = {
        command = "bash-language-server";
        args = [ "start" ];
      };
      language-server.clangd = {
        command = "clangd";
      };
      language-server.clojure-lsp = {
        command = "clojure-lsp";
      };
      language-server.elixir-ls = {
        command = "elixir-ls";
      };
      language-server.elm-language-server = {
        command = "elm-language-server";
      };
      language-server.haskell-language-server = {
        command = "haskell-language-server-wrapper";
        args = [ "--lsp" ];
      };
      language-server.intelephense = {
        command = "intelephense";
        args = [ "--stdio" ];
      };
      language-server.jdt-language-server = {
        command = "jdt-language-server";
      };
      language-server.kotlin-language-server = {
        command = "kotlin-language-server";
      };
      language-server.marksman = {
        command = "marksman";
        args = [ "server" ];
      };
      language-server.nixd = {
        command = "nixd";
      };
      language-server.ocaml-lsp = {
        command = "ocamllsp";
      };
      language-server.omnisharp = {
        command = "omnisharp";
        args = [ "-lsp" ];
      };
      language-server.perlnavigator = {
        command = "perlnavigator";
        args = [ "--stdio" ];
      };
      language-server.sourcekit-lsp = {
        command = "sourcekit-lsp";
      };
      language-server.sqls = {
        command = "sqls";
      };
      language-server.zls = {
        command = "zls";
      };

      # Languages
      language = [
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          formatter = { command = "rustfmt"; };
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "scala";
          language-servers = [ "metals" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "go";
          language-servers = [ "gopls" ];
          formatter = { command = "goimports-reviser"; };
          indent = { tab-width = 4; unit = "\t"; };
        }
        {
          name = "python";
          language-servers = [ "pyright" ];
          formatter = { command = "ruff"; args = [ "format" "--stdin-filename" "-" "-" ]; };
          indent = { tab-width = 4; unit = "    "; };
          auto-format = true;
        }
        {
          name = "latex";
          language-servers = [ "texlab" ];
          formatter = { command = "latexindent"; args = [ "-c" "-" "-o" "-" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "markdown";
          language-servers = [ "marksman" ];
          formatter = { command = "prettier"; args = [ "--parser" "markdown" ]; };
          indent = { tab-width = 2; unit = "  "; };
          soft-wrap = { enable = true; };
          rulers = [ ];
        }
        {
          name = "mermaid";
        }
        {
          name = "nix";
          language-servers = [ "nixd" ];
          formatter = { command = "nixpkgs-fmt"; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "lua";
          language-servers = [ "lua-ls" ];
          formatter = { command = "stylua"; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "toml";
          language-servers = [ "taplo" ];
          formatter = { command = "taplo"; args = [ "format" "-" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "yaml" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "javascript";
          language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "javascript" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "typescript";
          language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "typescript" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "jsx";
          language-id = "javascriptreact";
          language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "babel" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "tsx";
          language-id = "typescriptreact";
          language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "typescript" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "html";
          language-servers = [ "tailwindcss-language-server" "vscode-html-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "html" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "css";
          language-servers = [ "tailwindcss-language-server" "vscode-css-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "css" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "scss";
          language-servers = [ "tailwindcss-language-server" "vscode-css-language-server" ];
          formatter = { command = "prettier"; args = [ "--parser" "scss" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "ini";
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "bash";
          language-servers = [ "bash-language-server" ];
          formatter = { command = "shfmt"; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "c";
          language-servers = [ "clangd" ];
          formatter = { command = "clang-format"; };
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "cpp";
          language-servers = [ "clangd" ];
          formatter = { command = "clang-format"; };
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "clojure";
          language-servers = [ "clojure-lsp" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "elixir";
          language-servers = [ "elixir-ls" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "elm";
          language-servers = [ "elm-language-server" ];
          formatter = { command = "elm-format"; args = [ "--stdin" ]; };
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "haskell";
          language-servers = [ "haskell-language-server" ];
          formatter = { command = "fourmolu"; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "java";
          language-servers = [ "jdt-language-server" ];
          formatter = { command = "google-java-format"; args = [ "-" ]; };
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "kotlin";
          language-servers = [ "kotlin-language-server" ];
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "ocaml";
          language-servers = [ "ocaml-lsp" ];
          formatter = { command = "ocamlformat"; args = [ "--name" "-" "-" ]; };
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "perl";
          language-servers = [ "perlnavigator" ];
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "php";
          language-servers = [ "intelephense" ];
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "csharp";
          language-servers = [ "omnisharp" ];
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "sql";
          language-servers = [ "sqls" ];
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "swift";
          language-servers = [ "sourcekit-lsp" ];
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "zig";
          language-servers = [ "zls" ];
          formatter = { command = "zig"; args = [ "fmt" "--stdin" ]; };
          indent = { tab-width = 4; unit = "    "; };
        }
      ];
      file-type = [{
        name = "json";
        pattern = {
          suffix = ".code-workspace";
        };
      }];
    };
}
