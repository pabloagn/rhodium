local harpoon = require("harpoon")

-- --- Initialize Harpoon ---
harpoon:setup({
  settings = {
    save_on_toggle = false,
    sync_on_ui_close = false,
    key = function()
      return vim.loop.cwd()
    end,
  },
})

harpoon:extend(require("harpoon.extensions").builtins.highlight_current_file())
