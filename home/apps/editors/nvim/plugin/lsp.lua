-- Get capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Rust
require'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
}

-- Scala
require'lspconfig'.metals.setup{
  capabilities = capabilities,
}

-- Go
require'lspconfig'.gopls.setup{
  capabilities = capabilities,
}

-- Python (using pyright instead of pylsp for better performance)
require'lspconfig'.pyright.setup{
  capabilities = capabilities,
}

-- LaTeX
require'lspconfig'.texlab.setup{
  capabilities = capabilities,
}

-- Nix (nil)
require'lspconfig'.nil_ls.setup{
  capabilities = capabilities,
}

-- Lua
require'lspconfig'.lua_ls.setup{
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- TOML
require'lspconfig'.taplo.setup{
  capabilities = capabilities,
}

-- YAML
require'lspconfig'.yamlls.setup{
  capabilities = capabilities,
}

-- TypeScript/JavaScript
require'lspconfig'.ts_ls.setup{
  capabilities = capabilities,
}

-- Tailwind CSS
require'lspconfig'.tailwindcss.setup{
  capabilities = capabilities,
}

-- HTML
require'lspconfig'.html.setup{
  capabilities = capabilities,
}

-- CSS
require'lspconfig'.cssls.setup{
  capabilities = capabilities,
}

-- Bash
require'lspconfig'.bashls.setup{
  capabilities = capabilities,
}

-- C/C++
require'lspconfig'.clangd.setup{
  capabilities = capabilities,
}

-- Clojure
require'lspconfig'.clojure_lsp.setup{
  capabilities = capabilities,
}

-- Elixir
require'lspconfig'.elixirls.setup{
  capabilities = capabilities,
  cmd = { "elixir-ls" },
}

-- Elm
require'lspconfig'.elmls.setup{
  capabilities = capabilities,
}

-- Haskell
require'lspconfig'.hls.setup{
  capabilities = capabilities,
}

-- PHP
require'lspconfig'.intelephense.setup{
  capabilities = capabilities,
}

-- Java
require'lspconfig'.jdtls.setup{
  capabilities = capabilities,
}

-- Kotlin
require'lspconfig'.kotlin_language_server.setup{
  capabilities = capabilities,
}

-- Markdown
require'lspconfig'.marksman.setup{
  capabilities = capabilities,
}

-- Nix (nixd - enhanced)
require'lspconfig'.nixd.setup{
  capabilities = capabilities,
  settings = {
    ['nixd'] = {
      formatting = {
        command = { "nixpkgs-fmt" }
      },
      options = {
        enable = true,
        target = { "nixpkgs-25.01" }
      }
    }
  }
}

-- OCaml
require'lspconfig'.ocamllsp.setup{
  capabilities = capabilities,
}

-- C#
require'lspconfig'.omnisharp.setup{
  capabilities = capabilities,
}

-- Perl
require'lspconfig'.perlnavigator.setup{
  capabilities = capabilities,
}

-- Swift
require'lspconfig'.sourcekit.setup{
  capabilities = capabilities,
}

-- SQL
require'lspconfig'.sqls.setup{
  capabilities = capabilities,
}

-- Zig
require'lspconfig'.zls.setup{
  capabilities = capabilities,
}
