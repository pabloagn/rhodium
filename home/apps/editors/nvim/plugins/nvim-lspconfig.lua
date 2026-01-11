-- LSP Configuration using vim.lsp.config (Neovim 0.11+)
-- See :help lspconfig-nvim-0.11 for migration details

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Helper to define and enable an LSP server
local function setup(name, config)
  config = config or {}
  config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- Bash
setup("bashls")

-- C/C++
setup("clangd")

-- C#
setup("omnisharp")

-- CMake
setup("cmake")

-- Clojure
setup("clojure_lsp")

-- Crystal
setup("crystalline")

-- CSS
setup("cssls")

-- D language
setup("serve_d")

-- Deno (TypeScript/JavaScript alternative)
setup("denols", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, { "deno.json", "deno.jsonc" })
    if root then
      on_dir(root)
    end
  end,
})

-- Dhall
setup("dhall_lsp_server")

-- Docker
setup("dockerls")

-- Elixir
setup("elixirls", {
  cmd = { "elixir-ls" },
})

-- Elm
setup("elmls")

-- F#
setup("fsautocomplete")

-- Fennel
setup("fennel_ls")

-- Fish Shell
setup("fish_lsp", {
  cmd = { "fish-lsp", "start" },
  cmd_env = { fish_lsp_show_client_popups = false },
  filetypes = { "fish" },
})

-- Fortran
setup("fortls")

-- Gleam
setup("gleam")

-- GLSL
setup("glslls")

-- Go
setup("gopls")

-- GraphQL
setup("graphql")

-- Haskell
setup("hls")

-- HTML
setup("html", {
  filetypes = { "html", "gohtmltmpl", "htmldjango", "templ" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, {
      "hugo.toml",
      "hugo.yaml",
      "hugo.json",
      "config.toml",
      "config.yaml",
      "config.json",
      ".git",
    })
    if root then
      on_dir(root)
    end
  end,
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
setup("jdtls")

-- JSON (with JSONC support)
setup("jsonls", {
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
})

-- Just
setup("just")

-- Julia
setup("julials", {
  on_new_config = function(new_config, new_root_dir)
    local julia = vim.fn.expand("julia")
    if julia and julia ~= "" then
      new_config.cmd = {
        julia,
        "--startup-file=no",
        "--history-file=no",
        "--project=" .. new_root_dir,
        "-e",
        [[
          using Pkg;
          Pkg.instantiate();
          using LanguageServer, SymbolServer;
          env = dirname(Pkg.Types.Context().env.project_file);
          server = LanguageServer.LanguageServerInstance(stdin, stdout, env, "");
          server.runlinter = true;
          run(server);
        ]],
      }
    end
  end,
})

-- Kotlin
setup("kotlin_language_server")

-- LaTeX
setup("texlab")

-- Lua
setup("lua_ls")

-- Markdown
setup("marksman")

-- Nixd (Primary Nix LSP)
setup("nixd", {
  settings = {
    nixd = {
      flake = { enable = true },
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      diagnostic = {
        suppress = { "sema-extra-with" },
      },
    },
  },
})

-- Nil (Alternative Nix LSP)
setup("nil_ls", {
  settings = {
    ["nil"] = {
      flake = { autoArchive = true },
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
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Nushell
setup("nushell", {
  cmd = { "nu", "--lsp" },
  filetypes = { "nu" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, { ".git", "flake.nix", "pyproject.toml" })
    if root then
      on_dir(root)
    end
  end,
})

-- OCaml
setup("ocamllsp")

-- Odin
setup("ols", {
  init_options = {
    checker_args = "-strict-style",
    collections = {
      { name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
    },
  },
})

-- Perl
setup("perlnavigator")

-- PHP
setup("intelephense")

-- Prisma
setup("prismals")

-- Protocol Buffers
setup("buf_ls")

-- Python
setup("pyright")

-- R
setup("r_language_server")

-- Rust
setup("rust_analyzer")

-- Scala
setup("metals")

-- SQL
setup("sqls")

-- Svelte
setup("svelte")

-- Swift
setup("sourcekit")

-- EmmetLS (HTML expansion)
setup("emmet_ls", {
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

-- Jinja2
setup("jinja_lsp", {
  filetypes = { "jinja", "jinja2", "j2", "html.jinja", "html.j2" },
})

-- Tailwind CSS
setup("tailwindcss", {
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
          "class[\\s]*=[\\s]*[\"']([^\"']*)[\"']",
          'class[\\s]*=[\\s]*"([^"]*)"',
          "class[\\s]*=[\\s]*'([^']*)'",
        },
      },
    },
  },
})

-- Terraform
setup("terraformls")

-- TOML
setup("taplo")

-- TypeScript/JavaScript
setup("ts_ls")

-- Typst
setup("tinymist", {
  settings = {
    formatterMode = "typstyle",
    exportPdf = "never",
    semanticTokens = "disable",
  },
})

-- Vue (Volar for Vue 3)
setup("volar")

-- XML
setup("lemminx")

-- YAML
setup("yamlls")

-- Zig
setup("zls")
