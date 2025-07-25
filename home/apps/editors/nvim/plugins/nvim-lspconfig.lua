local capabilities = require("cmp_nvim_lsp").default_capabilities()
local functions = require("functions")

-- Bash
require("lspconfig").bashls.setup({
  capabilities = capabilities,
})

-- C/C++
require("lspconfig").clangd.setup({
  capabilities = capabilities,
})

-- C#
require("lspconfig").omnisharp.setup({
  capabilities = capabilities,
})

-- CMake
require("lspconfig").cmake.setup({
  capabilities = capabilities,
})

-- Clojure
require("lspconfig").clojure_lsp.setup({
  capabilities = capabilities,
})

-- Crystal
require("lspconfig").crystalline.setup({
  capabilities = capabilities,
})

-- CSS
require("lspconfig").cssls.setup({
  capabilities = capabilities,
})

-- D language
require("lspconfig").serve_d.setup({
  capabilities = capabilities,
})

-- -- Dart / Flutter
-- require 'lspconfig'.dartls.setup {
-- 	capabilities = capabilities,
-- }

-- Deno (TypeScript/JavaScript alternative)
require("lspconfig").denols.setup({
  capabilities = capabilities,
  root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
})

-- Dhall
require("lspconfig").dhall_lsp_server.setup({
  capabilities = capabilities,
})

-- Docker
require("lspconfig").dockerls.setup({
  capabilities = capabilities,
})

-- Elixir
require("lspconfig").elixirls.setup({
  capabilities = capabilities,
  cmd = { "elixir-ls" },
})

-- Elm
require("lspconfig").elmls.setup({
  capabilities = capabilities,
})

-- F#
require("lspconfig").fsautocomplete.setup({
  capabilities = capabilities,
})

-- Fennel
require("lspconfig").fennel_ls.setup({
  capabilities = capabilities,
})

-- Fish Shell
require("lspconfig").fish_lsp.setup({
  capabilities = capabilities,
  cmd = { "fish-lsp", "start" },
  cmd_env = { fish_lsp_show_client_popups = false },
  filetypes = { "fish" },
})

-- Fortran
require("lspconfig").fortls.setup({
  capabilities = capabilities,
})

-- Gleam
require("lspconfig").gleam.setup({
  capabilities = capabilities,
})

-- GLSL
require("lspconfig").glslls.setup({
  capabilities = capabilities,
})

-- Go
require("lspconfig").gopls.setup({
  capabilities = capabilities,
})

-- GraphQL
require("lspconfig").graphql.setup({
  capabilities = capabilities,
})

-- Haskell
require("lspconfig").hls.setup({
  capabilities = capabilities,
})

-- HTML
require("lspconfig").html.setup({
  capabilities = capabilities,
  filetypes = { "html", "gohtmltmpl", "htmldjango", "templ" },
  root_dir = require("lspconfig").util.root_pattern(
    "hugo.toml",
    "hugo.yaml",
    "hugo.json",
    "config.toml",
    "config.yaml",
    "config.json",
    ".git"
  ),
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 120,
        wrapAttributes = "auto",
      },
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
})

-- Java
require("lspconfig").jdtls.setup({
  capabilities = capabilities,
})

-- JSON (with JSONC support)
require("lspconfig").jsonls.setup({
  capabilities = capabilities,
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
      format = {
        enable = true,
      },
    },
  },
  init_options = {
    provideFormatter = true,
  },
  commands = {
    JsonFormat = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
    },
  },
})

-- Just
require("lspconfig").just.setup({
  capabilities = capabilities,
})

require("lspconfig").julia.setup({
  capabilities = capabilities,
  cmd = {
    "julia",
    "--startup-file=no",
    "--history-file=no",
    "-e",
    [[
    using LanguageServer, SymbolServer;
    import Pkg;
    env = dirname(Pkg.Types.Context().env.project_file);
    server = LanguageServer.LanguageServerInstance(stdin, stdout, env, "");
    server.runlinter = true;
    run(server);
  ]],
  },
})

-- Kotlin
require("lspconfig").kotlin_language_server.setup({
  capabilities = capabilities,
})

-- LaTeX
require("lspconfig").texlab.setup({
  capabilities = capabilities,
})

-- Lua
require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
})

-- Markdown
require("lspconfig").marksman.setup({
  capabilities = capabilities,
})

-- Nixd (Primary Nix LSP)
require("lspconfig").nixd.setup({
  capabilities = capabilities,
  settings = {
    nixd = {
      -- Tell nixd to enable flake support and infer the flake.nix location
      -- from the current working directory or nearest parent.
      flake = { enable = true },

      -- Keep nixpkgs expr for general Nixpkgs options and completions
      -- This is good for standard Nixpkgs options that aren't overridden.
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      diagnostic = {
        suppress = { "sema-extra-with" },
      },
    },
  },
})

require("lspconfig").nil_ls.setup({
  capabilities = capabilities,
  settings = {
    ["nil"] = {
      flake = { autoArchive = true }, -- Nil uses `autoArchive = true` for flake inference
      diagnostics = {
        ignored = { "unused_binding", "unused_with" },
        excludeFiles = { "*.generated.nix" },
      },
      nix = {
        flake = {
          autoArchive = true,
        },
      },
    },
  },
})

-- Performance optimization for Nix LSPs
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and (client.name == "nil_ls" or client.name == "nixd") then
      client.server_capabilities.semanticTokensProvider = nil -- Disable semantic tokens for better performance
    end
  end,
})

-- Nushell
require("lspconfig").nushell.setup({
  capabilities = capabilities,
  cmd = { "nu", "--lsp" },
  filetypes = { "nu" },
  root_dir = function(fname)
    return vim.fs.root(fname, { ".git", "flake.nix", "pyproject.toml" })
  end,
})

-- OCaml
require("lspconfig").ocamllsp.setup({
  capabilities = capabilities,
})

-- Odin
require("lspconfig").ols.setup({
  capabilities = capabilities,
  init_options = {
    checker_args = "-strict-style",
    collections = {
      { name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
    },
  },
})

-- Perl
require("lspconfig").perlnavigator.setup({
  capabilities = capabilities,
})

-- PHP
require("lspconfig").intelephense.setup({
  capabilities = capabilities,
})

-- Prisma
require("lspconfig").prismals.setup({
  capabilities = capabilities,
})

-- Protocol Buffers
require("lspconfig").buf_ls.setup({
  capabilities = capabilities,
})

-- Python
require("lspconfig").pyright.setup({
  capabilities = capabilities,
})

-- R
require("lspconfig").r_language_server.setup({
  capabilities = capabilities,
})

-- Rust
require("lspconfig").rust_analyzer.setup({
  capabilities = capabilities,
})

-- Scala
require("lspconfig").metals.setup({
  capabilities = capabilities,
})

-- SQL
require("lspconfig").sqls.setup({
  capabilities = capabilities,
})

-- Svelte
require("lspconfig").svelte.setup({
  capabilities = capabilities,
})

-- Swift
require("lspconfig").sourcekit.setup({
  capabilities = capabilities,
})

-- EmmetLS (HTML expansion)
require("lspconfig").emmet_ls.setup({
  capabilities = capabilities,
  filetypes = {
    "html",
    "gohtmltmpl",
    "css",
    "scss",
    "sass",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
})

-- Tailwind CSS
require("lspconfig").tailwindcss.setup({
  capabilities = capabilities,
  filetypes = {
    "html",
    "gohtmltmpl",
    "css",
    "scss",
    "sass",
    "javascript",
    "typescript",
    "vue",
    "svelte",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- Hugo template class detection
          "class[\\s]*=[\\s]*[\"']([^\"']*)[\"']",
          'class[\\s]*=[\\s]*"([^"]*)"',
          "class[\\s]*=[\\s]*'([^']*)'",
        },
      },
    },
  },
})

-- Terraform
require("lspconfig").terraformls.setup({
  capabilities = capabilities,
})

-- TOML
require("lspconfig").taplo.setup({
  capabilities = capabilities,
})

-- TypeScript/JavaScript
require("lspconfig").ts_ls.setup({
  capabilities = capabilities,
})

-- Typst
require("lspconfig")["tinymist"].setup({
  capabilities = capabilities,
  settings = {
    formatterMode = "typstyle",
    exportPdf = "never",
    semanticTokens = "disable",
  },
})

-- Vue (Volar for Vue 3)
require("lspconfig").volar.setup({
  capabilities = capabilities,
})

-- XML
require("lspconfig").lemminx.setup({
  capabilities = capabilities,
})

-- YAML
require("lspconfig").yamlls.setup({
  capabilities = capabilities,
})

-- Zig
require("lspconfig").zls.setup({
  capabilities = capabilities,
})
