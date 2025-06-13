local M = {}

-- ───────────────────────────────────────────────────────────────
-- Configuration
-- ───────────────────────────────────────────────────────────────

M.dirs = {
  academic = vim.fn.expand('$HOME/academic'),
  professional = vim.fn.expand('$HOME/professional'),
  projects = vim.fn.expand('$HOME/dev'),
  solenoidlabs = vim.fn.expand('$HOME/solenoid-labs'),
  vaults = vim.fn.expand('$HOME/vaults'),
  rhodium = vim.fn.expand('$HOME/dev/rhodium'),
}

-- ───────────────────────────────────────────────────────────────
-- Visual Elements
-- ───────────────────────────────────────────────────────────────

M.visuals = {
  logo = [[
  ╦═══╗┬   ┬┌───┐ ┌┬─┐┬┬   ┬┌─┬─┐
  ║   ║│   ││   │  │ │││   ││ │ │
  ╠═╦═╝├───┤│   │  │ │││   ││ │ │
  ║ ║  │   ││   │  │ │││   ││ │ │
  ╩ ╚══┴   ┴└───┘──┴─┘┴└───┘┴   ┴
]],

  footer = "────────────── ‡ ──────────────",

  icons = {
    primary = "⊹",
    secondary = "›",
    back = "‹",
    dot = "·",
    diamond = "◆",
  }
}

-- ───────────────────────────────────────────────────────────────
-- Menu State Management
-- ───────────────────────────────────────────────────────────────

M.state = {
  current = "main",
  history = {},
}

function M.navigate_to(menu)
  if M.menus[menu] then
    table.insert(M.state.history, M.state.current)
    M.state.current = menu
    M.refresh()
  end
end

function M.navigate_back()
  if #M.state.history > 0 then
    M.state.current = table.remove(M.state.history)
    M.refresh()
  end
end

function M.refresh()
  vim.cmd('Dashboard')
end

-- ───────────────────────────────────────────────────────────────
-- Action Builders
-- ───────────────────────────────────────────────────────────────

local actions = {}

function actions.telescope_files(title, cwd, opts)
  return function()
    require('telescope.builtin').find_files(vim.tbl_extend('force', {
      prompt_title = title,
      cwd = cwd,
    }, opts or {}))
  end
end

function actions.telescope_directory_picker(title, base_dir, depth)
  depth = depth or 1
  return function()
    local builtin = require('telescope.builtin')
    local telescope_actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    builtin.find_files({
      prompt_title = title,
      cwd = base_dir,
      find_command = { 'fd', '--type', 'd', '--max-depth', tostring(depth), '--exclude', '.git' },
      attach_mappings = function(prompt_bufnr, map)
        telescope_actions.select_default:replace(function()
          telescope_actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            local selected_path = base_dir .. '/' .. selection[1]
            vim.cmd('cd ' .. selected_path)
            builtin.find_files({ cwd = selected_path })
          end
        end)
        return true
      end,
    })
  end
end

function actions.create_file()
  return function()
    local filename = vim.fn.input("New file: ")
    if filename ~= "" then
      vim.cmd("enew")
      vim.cmd("file " .. filename)
    end
  end
end

function actions.org_mode()
  return function()
    -- Placeholder for org mode
    vim.notify("Org mode will be available after plugin installation",
      vim.log.levels.INFO, { title = "Org Mode" })
    require('orgmode').agenda()
  end
end

-- ───────────────────────────────────────────────────────────────
-- Menu Definitions
-- ───────────────────────────────────────────────────────────────

M.menus = {
  main = {
    { key = "f", desc = "Files",    icon = M.visuals.icons.primary, action = function() M.navigate_to("files") end },
    { key = "z", desc = "Navigate", icon = M.visuals.icons.primary, action = function() M.navigate_to("navigate") end },
    {
      key = "r",
      desc = "Recent",
      icon = M.visuals.icons.primary,
      action = function()
        require('telescope').extensions
            .frecency.frecency()
      end
    },
    { key = "nf", desc = "New File", icon = M.visuals.icons.primary, action = actions.create_file() },
    { key = "o",  desc = "Org Mode", icon = M.visuals.icons.primary, action = actions.org_mode() },
    { key = "s",  desc = "System",   icon = M.visuals.icons.primary, action = function() M.navigate_to("system") end },
    { key = "p",  desc = "Projects", icon = M.visuals.icons.primary, action = function() M.navigate_to("projects") end },
    { key = "?",  desc = "Help",     icon = M.visuals.icons.primary, action = function() M.show_help() end },
    { key = "q",  desc = "Quit",     icon = M.visuals.icons.primary, action = "qa" },
  },

  files = {
    { key = "r", desc = "Rhodium",    icon = M.visuals.icons.secondary, action = actions.telescope_files('Rhodium', M.dirs.rhodium) },
    { key = "f", desc = "Find Files", icon = M.visuals.icons.secondary, action = actions.telescope_files('Files', nil, { hidden = false, no_ignore = false }) },
    { key = "a", desc = "All Files",  icon = M.visuals.icons.secondary, action = actions.telescope_files('All Files', nil, { hidden = true, no_ignore = true }) },
    {
      key = "g",
      desc = "Grep",
      icon = M.visuals.icons.secondary,
      action = function()
        require('telescope.builtin')
            .live_grep()
      end
    },
    {
      key = "G",
      desc = "Git Files",
      icon = M.visuals.icons.secondary,
      action = function()
        require('telescope.builtin')
            .git_files()
      end
    },
    { key = "b", desc = "Back", icon = M.visuals.icons.back, action = function() M.navigate_back() end },
  },

  navigate = {
    { key = "a", desc = "Academic",      icon = M.visuals.icons.secondary, action = actions.telescope_directory_picker('Academic', M.dirs.academic) },
    { key = "w", desc = "Professional",  icon = M.visuals.icons.secondary, action = actions.telescope_directory_picker('Professional', M.dirs.professional) },
    { key = "p", desc = "Projects",      icon = M.visuals.icons.secondary, action = actions.telescope_directory_picker('Projects', M.dirs.projects, 2) },
    { key = "s", desc = "Solenoid Labs", icon = M.visuals.icons.secondary, action = actions.telescope_directory_picker('Solenoid Labs', M.dirs.solenoidlabs, 2) },
    { key = "v", desc = "Vaults",        icon = M.visuals.icons.secondary, action = actions.telescope_directory_picker('Vaults', M.dirs.vaults) },
    { key = "b", desc = "Back",          icon = M.visuals.icons.back,      action = function() M.navigate_back() end },
  },

  system = {
    { key = "h", desc = "Health", icon = M.visuals.icons.secondary, action = "checkhealth" },
    { key = "m", desc = "Mason",  icon = M.visuals.icons.secondary, action = "Mason" },
    { key = "l", desc = "Lazy",   icon = M.visuals.icons.secondary, action = "Lazy" },
    {
      key = "c",
      desc = "Config",
      icon = M.visuals.icons.secondary,
      action = function()
        vim.cmd('e ' ..
          vim.fn.stdpath('config') .. '/init.lua')
      end
    },
    { key = "M", desc = "Messages", icon = M.visuals.icons.secondary, action = "messages" },
    { key = "b", desc = "Back",     icon = M.visuals.icons.back,      action = function() M.navigate_back() end },
  },

  projects = {
    { key = "n", desc = "New Project", icon = M.visuals.icons.secondary, action = function() M.navigate_to("templates") end },
    { key = "s", desc = "Sessions",    icon = M.visuals.icons.secondary, action = function() M.navigate_to("sessions") end },
    {
      key = "t",
      desc = "TODOs",
      icon = M.visuals.icons.secondary,
      action = function()
        vim.cmd(
          "Telescope todo-comments")
      end
    },
    {
      key = "d",
      desc = "Diagnostics",
      icon = M.visuals.icons.secondary,
      action = function()
        vim.cmd(
          "Telescope diagnostics")
      end
    },
    { key = "g", desc = "Git Status", icon = M.visuals.icons.secondary, action = function() vim.cmd("Git") end },
    { key = "b", desc = "Back",       icon = M.visuals.icons.back,      action = function() M.navigate_back() end },
  },

  templates = {
    { key = "r", desc = "Rust",          icon = M.visuals.icons.diamond, action = function() M.create_project("rust") end },
    { key = "p", desc = "Python",        icon = M.visuals.icons.diamond, action = function() M.create_project("python") end },
    { key = "n", desc = "Neovim Plugin", icon = M.visuals.icons.diamond, action = function() M.create_project("nvim") end },
    { key = "c", desc = "C",             icon = M.visuals.icons.diamond, action = function() M.create_project("c") end },
    { key = "l", desc = "Lua",           icon = M.visuals.icons.diamond, action = function() M.create_project("lua") end },
    { key = "b", desc = "Back",          icon = M.visuals.icons.back,    action = function() M.navigate_back() end },
  },

  sessions = {
    {
      key = "l",
      desc = "Load Last",
      icon = M.visuals.icons.secondary,
      action = function()
        vim.notify(
          "Session management not configured", vim.log.levels.WARN)
      end
    },
    {
      key = "s",
      desc = "Save",
      icon = M.visuals.icons.secondary,
      action = function()
        vim.notify(
          "Session management not configured", vim.log.levels.WARN)
      end
    },
    {
      key = "d",
      desc = "Delete",
      icon = M.visuals.icons.secondary,
      action = function()
        vim.notify(
          "Session management not configured", vim.log.levels.WARN)
      end
    },
    { key = "b", desc = "Back", icon = M.visuals.icons.back, action = function() M.navigate_back() end },
  },
}

-- ───────────────────────────────────────────────────────────────
-- Project Templates
-- ───────────────────────────────────────────────────────────────

M.project_templates = {
  rust = function(name)
    local path = vim.fn.expand(M.dirs.projects .. "/" .. name)
    vim.fn.system("cargo new " .. path)
    vim.cmd("cd " .. path)
    vim.cmd("e src/main.rs")
  end,

  python = function(name)
    local path = vim.fn.expand(M.dirs.projects .. "/" .. name)
    vim.fn.mkdir(path, "p")
    vim.fn.system("cd " .. path .. " && python -m venv .venv")
    vim.fn.writefile({
      "#!/usr/bin/env python3",
      '"""' .. name .. '"""',
      "",
      "def main():",
      '    print("Hello from ' .. name .. '")',
      "",
      'if __name__ == "__main__":',
      "    main()"
    }, path .. "/main.py")
    vim.cmd("cd " .. path)
    vim.cmd("e main.py")
  end,

  nvim = function(name)
    local path = vim.fn.expand(M.dirs.projects .. "/" .. name .. ".nvim")
    vim.fn.mkdir(path .. "/lua/" .. name, "p")
    vim.fn.mkdir(path .. "/plugin", "p")
    vim.fn.writefile({
      "local M = {}",
      "",
      "function M.setup(opts)",
      "  opts = opts or {}",
      "end",
      "",
      "return M"
    }, path .. "/lua/" .. name .. "/init.lua")
    vim.cmd("cd " .. path)
    vim.cmd("e lua/" .. name .. "/init.lua")
  end,

  c = function(name)
    local path = vim.fn.expand(M.dirs.projects .. "/" .. name)
    vim.fn.mkdir(path .. "/src", "p")
    vim.fn.mkdir(path .. "/include", "p")
    vim.fn.writefile({
      "CC = gcc",
      "CFLAGS = -Wall -Wextra -g",
      "TARGET = " .. name,
      "",
      "$(TARGET): src/main.c",
      "\t$(CC) $(CFLAGS) -o $(TARGET) src/main.c",
      "",
      "clean:",
      "\trm -f $(TARGET)",
      "",
      ".PHONY: clean"
    }, path .. "/Makefile")
    vim.fn.writefile({
      "#include <stdio.h>",
      "",
      "int main(void) {",
      '    printf("Hello from ' .. name .. '\\n");',
      "    return 0;",
      "}"
    }, path .. "/src/main.c")
    vim.cmd("cd " .. path)
    vim.cmd("e src/main.c")
  end,

  lua = function(name)
    local path = vim.fn.expand(M.dirs.projects .. "/" .. name)
    vim.fn.mkdir(path, "p")
    vim.fn.writefile({
      "-- " .. name,
      "",
      "local M = {}",
      "",
      "function M.main()",
      '  print("Hello from ' .. name .. '")',
      "end",
      "",
      "return M"
    }, path .. "/init.lua")
    vim.cmd("cd " .. path)
    vim.cmd("e init.lua")
  end,
}

function M.create_project(template)
  local name = vim.fn.input("Project name: ")
  if name ~= "" and M.project_templates[template] then
    M.project_templates[template](name)
  end
end

-- ───────────────────────────────────────────────────────────────
-- Keybindings
-- ───────────────────────────────────────────────────────────────

function M.setup_keybindings()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dashboard",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()

      -- Universal bindings
      vim.keymap.set("n", "q", ":q<CR>", { buffer = buf, silent = true })
      vim.keymap.set("n", "/", "<Nop>", { buffer = buf, silent = true })
      vim.keymap.set("n", "?", function() M.show_help() end, { buffer = buf, silent = true })

      -- Dynamic menu bindings
      local menu = M.menus[M.state.current]
      if menu then
        for _, item in ipairs(menu) do
          if type(item.action) == "function" then
            vim.keymap.set("n", item.key, item.action,
              { buffer = buf, silent = true, desc = item.desc })
          elseif type(item.action) == "string" then
            vim.keymap.set("n", item.key, "<cmd>" .. item.action .. "<CR>",
              { buffer = buf, silent = true, desc = item.desc })
          end
        end
      end
    end,
  })
end

-- ───────────────────────────────────────────────────────────────
-- Help System
-- ───────────────────────────────────────────────────────────────

function M.show_help()
  local menu = M.menus[M.state.current]
  local lines = {
    "⊱ " .. M.state.current:upper() .. " ⊰",
    "",
  }

  for _, item in ipairs(menu) do
    table.insert(lines, string.format("[%s] %s %s", item.key, item.icon, item.desc))
  end

  if #M.state.history > 0 then
    table.insert(lines, "")
    table.insert(lines, "Press 'b' to go back")
  end

  require('telescope.pickers').new({}, {
    prompt_title = '⊱ Dashboard Help ⊰',
    finder = require('telescope.finders').new_table({
      results = lines,
    }),
    sorter = require('telescope.config').values.generic_sorter({}),
    layout_config = {
      width = 0.5,
      height = 0.6,
    },
  }):find()
end

-- ───────────────────────────────────────────────────────────────
-- Dashboard Integration
-- ───────────────────────────────────────────────────────────────

function M.get_header()
  local header = M.visuals.logo
  header = string.rep("\n", 8) .. header .. "\n\n"
  return vim.split(header, "\n")
end

function M.get_footer()
  return { M.visuals.footer }
end

function M.get_center()
  local menu = M.menus[M.state.current]
  local items = {}

  for _, item in ipairs(menu) do
    table.insert(items, {
      action = item.action,
      desc = " " .. item.desc,
      icon = item.icon .. " ",
      key = item.key,
    })
  end

  return items
end

-- ───────────────────────────────────────────────────────────────
-- Setup
-- ───────────────────────────────────────────────────────────────

function M.setup()
  M.setup_keybindings()

  require('dashboard').setup {
    theme = 'doom',
    hide = {
      statusline = false,
      tabline = true,
      winbar = true,
    },
    config = {
      header = M.get_header(),
      center = M.get_center(),
      footer = M.get_footer,
    },
  }
end

return M
