-- Logs
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = { "*.log", "*.log.*", "/var/log/*", "syslog.*" },
  callback = function()
    vim.opt.syntax = "messages"
  end,
})

-- .env.local
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = { ".env", ".env.*", ".env.local" },
  callback = function()
    vim.opt.syntax = "sh"
  end,
})

-- .venv
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = { ".venv", "**/.venv/**", "pyvenv.cfg" },
  callback = function()
    vim.opt.syntax = "conf"
  end,
})
