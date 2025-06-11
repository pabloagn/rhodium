-- Get capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Just
require 'lspconfig'.just.setup {
	capabilities = capabilities,
}

-- Lua
require 'lspconfig'.lua_ls.setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				},
			},
			diagnostics = {
				globals = { "vim" }, -- avoid false positives
			},
		}
	}
}

-- Fish Shell
require 'lspconfig'.fish_lsp.setup {
	capabilities = capabilities,
	cmd = { 'fish-lsp', 'start' },
	cmd_env = { fish_lsp_show_client_popups = false },
	filetypes = { "fish" },
}

-- Nushell
require 'lspconfig'.nushell.setup {
	capabilities = capabilities,
	cmd = { "nu", "--lsp" },
	filetypes = { "nu" },
	root_dir = function(fname)
		return vim.fs.root(fname, { ".git", "flake.nix", "pyproject.toml" })
	end,
}

-- Rust
require 'lspconfig'.rust_analyzer.setup {
	capabilities = capabilities,
}

-- Scala
require 'lspconfig'.metals.setup {
	capabilities = capabilities,
}

-- Go
require 'lspconfig'.gopls.setup {
	capabilities = capabilities,
}

-- Python
require 'lspconfig'.pyright.setup {
	capabilities = capabilities,
}

-- LaTeX
require 'lspconfig'.texlab.setup {
	capabilities = capabilities,
}

-- Nix (Nil)
require 'lspconfig'.nil_ls.setup {
	capabilities = capabilities,
	settings = {
		['nil'] = {
			nix = {
				flake = {
					autoArchive = true
				}
			}
		}
	}
}

-- Nix (Nixd)
-- TODO: Improve this massively
require 'lspconfig'.nixd.setup {
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

-- TOML
require 'lspconfig'.taplo.setup {
	capabilities = capabilities,
}

-- YAML
require 'lspconfig'.yamlls.setup {
	capabilities = capabilities,
}

-- TypeScript/JavaScript
require 'lspconfig'.ts_ls.setup {
	capabilities = capabilities,
}

-- Tailwind CSS
require 'lspconfig'.tailwindcss.setup {
	capabilities = capabilities,
}

-- HTML
require 'lspconfig'.html.setup {
	capabilities = capabilities,
}

-- CSS
require 'lspconfig'.cssls.setup {
	capabilities = capabilities,
}

-- Bash
require 'lspconfig'.bashls.setup {
	capabilities = capabilities,
}

-- C/C++
require 'lspconfig'.clangd.setup {
	capabilities = capabilities,
}

-- Clojure
require 'lspconfig'.clojure_lsp.setup {
	capabilities = capabilities,
}

-- Elixir
require 'lspconfig'.elixirls.setup {
	capabilities = capabilities,
	cmd = { "elixir-ls" },
}

-- Elm
require 'lspconfig'.elmls.setup {
	capabilities = capabilities,
}

-- Haskell
require 'lspconfig'.hls.setup {
	capabilities = capabilities,
}

-- PHP
require 'lspconfig'.intelephense.setup {
	capabilities = capabilities,
}

-- Java
require 'lspconfig'.jdtls.setup {
	capabilities = capabilities,
}

-- Kotlin
require 'lspconfig'.kotlin_language_server.setup {
	capabilities = capabilities,
}

-- Markdown
require 'lspconfig'.marksman.setup {
	capabilities = capabilities,
}

-- OCaml
require 'lspconfig'.ocamllsp.setup {
	capabilities = capabilities,
}

-- C#
require 'lspconfig'.omnisharp.setup {
	capabilities = capabilities,
}

-- Perl
require 'lspconfig'.perlnavigator.setup {
	capabilities = capabilities,
}

-- Swift
require 'lspconfig'.sourcekit.setup {
	capabilities = capabilities,
}

-- SQL
require 'lspconfig'.sqls.setup {
	capabilities = capabilities,
}

-- Zig
require 'lspconfig'.zls.setup {
	capabilities = capabilities,
}

-- TODO: Add new servers
--
-- -- Docker
-- require 'lspconfig'.dockerls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: dockerfile-language-server-nodejs
--
-- -- JSON
-- require 'lspconfig'.jsonls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: vscode-langservers-extracted
--
-- -- GraphQL
-- require 'lspconfig'.graphql.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: graphql-language-service-cli
--
-- -- Vue (Volar for Vue 3)
-- require 'lspconfig'.volar.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: vue-language-server
--
-- -- Svelte
-- require 'lspconfig'.svelte.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: svelte-language-server
--
-- -- Solidity
-- require 'lspconfig'.solidity.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: solidity-language-server
--
-- -- XML
-- require 'lspconfig'.lemminx.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: lemminx
--
-- -- Angular
-- require 'lspconfig'.angularls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: angular-language-server
--
-- -- R
-- require 'lspconfig'.r_language_server.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: R (ensure it's in your env) + r-languageserver
--
-- -- Julia
-- require 'lspconfig'.julials.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: julia + juliaPackages.LanguageServer
--
-- -- Dart / Flutter
-- require 'lspconfig'.dartls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: dart (comes with dart analysis server)
--
-- -- ReasonML / ReScript
-- require 'lspconfig'.rescriptls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: rescript-language-server
--
-- -- F#
-- require 'lspconfig'.fsautocomplete.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: fsautocomplete
--
-- -- Fortran
-- require 'lspconfig'.fortls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: fortls
--
-- -- PowerShell
-- require 'lspconfig'.powershell_es.setup {
--   capabilities = capabilities,
--   bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
-- }
-- -- Nix package: powershellEditorServices (not in upstream nixpkgs, needs manual install or use Mason)
--
-- -- ProtoBuf
-- require 'lspconfig'.bufls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: bufls
--
-- -- Haxe
-- require 'lspconfig'.haxe_language_server.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: haxe + haxe-language-server
--
-- -- Terraform
-- require 'lspconfig'.terraformls.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: terraform-ls
--
-- -- Puppet
-- require 'lspconfig'.puppet.setup {
--   capabilities = capabilities,
-- }
-- -- Nix package: puppet-editor-services

-- Odin
require 'lspconfig'.ols.setup {
	capabilities = capabilities,
	init_options = {
		checker_args = "-strict-style",
		collections = {
			{ name = "shared", path = vim.fn.expand('$HOME/odin-lib') }
		},
	},
}
