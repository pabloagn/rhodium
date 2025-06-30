{...}: {
  programs.helix.languages = {
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
      args = ["--stdio"];
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
      args = ["lsp" "stdio"];
    };
    language-server."yaml-language-server" = {
      command = "yaml-language-server";
      args = ["--stdio"];
    };
    language-server."typescript-language-server" = {
      command = "typescript-language-server";
      args = ["--stdio"];
    };
    language-server."tailwindcss-language-server" = {
      command = "tailwindcss-language-server";
      args = ["--stdio"];
    };
    language-server."vscode-html-language-server" = {
      command = "vscode-html-language-server";
      args = ["--stdio"];
    };
    language-server."vscode-css-language-server" = {
      command = "vscode-css-language-server";
      args = ["--stdio"];
    };
    language-server.bash-language-server = {
      command = "bash-language-server";
      args = ["start"];
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
      args = ["--lsp"];
    };
    language-server.intelephense = {
      command = "intelephense";
      args = ["--stdio"];
    };
    language-server.jdt-language-server = {
      command = "jdt-language-server";
    };
    language-server.kotlin-language-server = {
      command = "kotlin-language-server";
    };
    language-server.marksman = {
      command = "marksman";
      args = ["server"];
    };
    language-server.nixd = {
      command = "nixd";
    };
    language-server.ocaml-lsp = {
      command = "ocamllsp";
    };
    language-server.omnisharp = {
      command = "omnisharp";
      args = ["-lsp"];
    };
    language-server.perlnavigator = {
      command = "perlnavigator";
      args = ["--stdio"];
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
  };
}
