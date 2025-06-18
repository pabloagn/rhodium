local capabilities = require("cmp_nvim_lsp").default_capabilities()
local functions = require("functions")

-- Just
require("lspconfig").just.setup({
	capabilities = capabilities,
})

-- Fennel
require("lspconfig").fennel_ls.setup({
	capabilities = capabilities,
})

-- Lua
require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- avoid false positives
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				},
			},
		},
	},
})

-- Fish Shell
require("lspconfig").fish_lsp.setup({
	capabilities = capabilities,
	cmd = { "fish-lsp", "start" },
	cmd_env = { fish_lsp_show_client_popups = false },
	filetypes = { "fish" },
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

-- Rust
require("lspconfig").rust_analyzer.setup({
	capabilities = capabilities,
})

-- Scala
require("lspconfig").metals.setup({
	capabilities = capabilities,
})

-- Go
require("lspconfig").gopls.setup({
	capabilities = capabilities,
})

-- Python
require("lspconfig").pyright.setup({
	capabilities = capabilities,
})

-- LaTeX
require("lspconfig").texlab.setup({
	capabilities = capabilities,
})

-- Nixd (Primary Nix LSP)
require("lspconfig").nixd.setup({
	capabilities = capabilities,
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "nixfmt" },
			},
			options = {
				nixos = {
					expr = string.format(
						'(builtins.getFlake "/etc/nixos").nixosConfigurations.%s.options',
						functions.get_hostname()
					),
				},
				home_manager = {
					expr = string.format(
						'(builtins.getFlake "/etc/nixos").homeConfigurations."%s@%s".options',
						functions.get_username(),
						functions.get_hostname()
					),
				},
			},
			diagnostic = {
				suppress = { "sema-extra-with" },
			},
		},
	},
})

-- Nil (Fallback Nix LSP for performance)
require("lspconfig").nil_ls.setup({
	capabilities = capabilities,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixfmt" },
			},
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
			-- Disable semantic tokens for better performance
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

-- TOML
require("lspconfig").taplo.setup({
	capabilities = capabilities,
})

-- YAML
require("lspconfig").yamlls.setup({
	capabilities = capabilities,
})

-- TypeScript/JavaScript
require("lspconfig").ts_ls.setup({
	capabilities = capabilities,
})

-- Tailwind CSS
require("lspconfig").tailwindcss.setup({
	capabilities = capabilities,
})

-- HTML
require("lspconfig").html.setup({
	capabilities = capabilities,
})

-- CSS
require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

-- Bash
require("lspconfig").bashls.setup({
	capabilities = capabilities,
})

-- C/C++
require("lspconfig").clangd.setup({
	capabilities = capabilities,
})

-- Clojure
require("lspconfig").clojure_lsp.setup({
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

-- Haskell
require("lspconfig").hls.setup({
	capabilities = capabilities,
})

-- PHP
require("lspconfig").intelephense.setup({
	capabilities = capabilities,
})

-- Java
require("lspconfig").jdtls.setup({
	capabilities = capabilities,
})

-- Kotlin
require("lspconfig").kotlin_language_server.setup({
	capabilities = capabilities,
})

-- Markdown
require("lspconfig").marksman.setup({
	capabilities = capabilities,
})

-- OCaml
require("lspconfig").ocamllsp.setup({
	capabilities = capabilities,
})

-- C#
require("lspconfig").omnisharp.setup({
	capabilities = capabilities,
})

-- Perl
require("lspconfig").perlnavigator.setup({
	capabilities = capabilities,
})

-- Swift
require("lspconfig").sourcekit.setup({
	capabilities = capabilities,
})

-- SQL
require("lspconfig").sqls.setup({
	capabilities = capabilities,
})

-- Zig
require("lspconfig").zls.setup({
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

-- Docker
require("lspconfig").dockerls.setup({
	capabilities = capabilities,
})

-- JSON (requires schemastore.nvim plugin)
-- require 'lspconfig'.jsonls.setup {
--   capabilities = capabilities,
--   settings = {
--     json = {
--       schemas = require('schemastore').json.schemas(),
--       validate = { enable = true },
--     },
--   },
-- }

-- JSON (with JSONC support)
require("lspconfig").jsonls.setup({
	capabilities = capabilities,
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
			-- Allow comments in JSONC
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

-- GraphQL
require("lspconfig").graphql.setup({
	capabilities = capabilities,
})

-- Vue (Volar for Vue 3)
require("lspconfig").volar.setup({
	capabilities = capabilities,
})

-- Svelte
require("lspconfig").svelte.setup({
	capabilities = capabilities,
})

-- XML
require("lspconfig").lemminx.setup({
	capabilities = capabilities,
})

-- R
require("lspconfig").r_language_server.setup({
	capabilities = capabilities,
})

-- -- Dart / Flutter
-- require 'lspconfig'.dartls.setup {
-- 	capabilities = capabilities,
-- }

-- F#
require("lspconfig").fsautocomplete.setup({
	capabilities = capabilities,
})

-- Fortran
require("lspconfig").fortls.setup({
	capabilities = capabilities,
})

-- Protocol Buffers
require("lspconfig").buf_ls.setup({
	capabilities = capabilities,
})

-- Terraform
require("lspconfig").terraformls.setup({
	capabilities = capabilities,
})

-- CMake
require("lspconfig").cmake.setup({
	capabilities = capabilities,
})

-- Crystal
require("lspconfig").crystalline.setup({
	capabilities = capabilities,
})

-- D language
require("lspconfig").serve_d.setup({
	capabilities = capabilities,
})

-- Deno (TypeScript/JavaScript alternative)
require("lspconfig").denols.setup({
	capabilities = capabilities,
	root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
})

-- Dhall
require("lspconfig").dhall_lsp_server.setup({
	capabilities = capabilities,
})

-- GLSL
require("lspconfig").glslls.setup({
	capabilities = capabilities,
})

-- Prisma
require("lspconfig").prismals.setup({
	capabilities = capabilities,
})

-- -- Rome (JS/TS formatter/linter)
-- require 'lspconfig'.rome.setup {
-- 	capabilities = capabilities,
-- }
