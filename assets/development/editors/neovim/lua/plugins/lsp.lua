-----------------------------------------------------------
-- Route:............user/dev/nvim/plugin/lsp.lua
-- Type:.............Module
-- Created by:.......Pablo Aguirre
-----------------------------------------------------------

-- Get capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup nil language server (Nix)
require'lspconfig'.nil_ls.setup{
  capabilities = capabilities,
}

-- Setup Python language server
require'lspconfig'.pylsp.setup{
  capabilities = capabilities,
}

-- Setup nixd language server (Nix enhanced)
require'lspconfig'.nixd.setup{
  capabilities = capabilities,
  settings = {
    ['nixd'] = {
      formatting = {
        command = { "nixpkgs-fmt" }
      },
      options = {
        enable = true,
        target = { "nixpkgs-24.11" }  -- Set to your NixOS version
      }
    }
  }
}
