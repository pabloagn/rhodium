local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function open_in_new_terminal(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  
  local file_path = selection.path or selection.filename
  vim.fn.system(string.format("kitty -- nvim '%s' &", file_path))
end

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-t>"] = open_in_new_terminal,
      },
      n = {
        ["<C-t>"] = open_in_new_terminal,
      }
    }
  }
})
