local dirs = {
  academic = vim.fn.expand('$HOME/academic'),
  professional = vim.fn.expand('$HOME/professional'),
  projects = vim.fn.expand('$HOME/dev'),
  solenoidlabs = vim.fn.expand('$HOME/solenoid-labs'),

  vaults = vim.fn.expand('$HOME/vaults'),
  rhodium = vim.fn.expand('$HOME/dev/rhodium'),
}

local function get_logo()
  local logo = [[
  ╦═══╗┬   ┬┌───┐ ┌┬─┐┬┬   ┬┌─┬─┐
  ║   ║│   ││   │  │ │││   ││ │ │
  ╠═╦═╝├───┤│   │  │ │││   ││ │ │
  ║ ║  │   ││   │  │ │││   ││ │ │
  ╩ ╚══┴   ┴└───┘──┴─┘┴└───┘┴   ┴
]]
  logo = string.rep("\n", 8) .. logo .. "\n\n"
  return vim.split(logo, "\n")
end

local function get_footer()
  return { "────────────── ‡ ──────────────" }
end

-- Custom keybindings for dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function()
    -- Quit with q
    vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })

    -- Disable search
    vim.keymap.set("n", "/", "<Nop>", { buffer = true, silent = true })

    -- Two-key mappings
    -- Files mappings
    vim.keymap.set("n", "fr", function()
      require('telescope.builtin').find_files({
        prompt_title = 'Rhodium',
        cwd = dirs.rhodium,
      })
    end, { buffer = true, silent = true, desc = "Files Rhodium" })

    vim.keymap.set("n", "fR", function()
      require('telescope').extensions.frecency.frecency({
        prompt_title = 'Recent Files',
      })
    end, { buffer = true, silent = true, desc = "Files Recent" })

    vim.keymap.set("n", "ff", function()
      require('telescope.builtin').find_files({
        prompt_title = 'Files',
        hidden = false,
        no_ignore = false,
      })
    end, { buffer = true, silent = true, desc = "Files" })

    vim.keymap.set("n", "fa", function()
      require('telescope.builtin').find_files({
        prompt_title = 'All Files',
        hidden = true,
        no_ignore = true,
      })
    end, { buffer = true, silent = true, desc = "Files All" })

    -- Z mappings (navigation)
    vim.keymap.set("n", "za", function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      builtin.find_files({
        prompt_title = 'Academic',
        cwd = dirs.academic,
        find_command = { 'fd', '--type', 'd', '--max-depth', '1', '--exclude', '.git' },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              local academic_path = dirs.academic .. '/' .. selection[1]
              vim.cmd('cd ' .. academic_path)
              builtin.find_files({ cwd = academic_path })
            end
          end)
          return true
        end,
      })
    end, { buffer = true, silent = true, desc = "Z Academic" })

    vim.keymap.set("n", "zw", function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      builtin.find_files({
        prompt_title = 'Professional',
        cwd = dirs.professional,
        find_command = { 'fd', '--type', 'd', '--max-depth', '1', '--exclude', '.git' },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              local professional_path = dirs.professional .. '/' .. selection[1]
              vim.cmd('cd ' .. professional_path)
              builtin.find_files({ cwd = professional_path })
            end
          end)
          return true
        end,
      })
    end, { buffer = true, silent = true, desc = "Z Professional (Work)" })

    vim.keymap.set("n", "zp", function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      builtin.find_files({
        prompt_title = 'Projects',
        cwd = dirs.projects,
        find_command = { 'fd', '--type', 'd', '--max-depth', '2', '--exclude', '.git' },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              local project_path = dirs.projects .. '/' .. selection[1]
              vim.cmd('cd ' .. project_path)
              builtin.find_files({ cwd = project_path })
            end
          end)
          return true
        end,
      })
    end, { buffer = true, silent = true, desc = "Z Project" })

    vim.keymap.set("n", "zs", function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      builtin.find_files({
        prompt_title = 'Solenoid Labs',
        cwd = dirs.solenoidlabs,
        find_command = { 'fd', '--type', 'd', '--max-depth', '2', '--exclude', '.git' },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              local solenoid_path = dirs.solenoidlabs .. '/' .. selection[1]
              vim.cmd('cd ' .. solenoid_path)
              builtin.find_files({ cwd = solenoid_path })
            end
          end)
          return true
        end,
      })
    end, { buffer = true, silent = true, desc = "Z Solenoid Labs" })

    vim.keymap.set("n", "zv", function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      builtin.find_files({
        prompt_title = 'Vaults',
        cwd = dirs.vaults,
        find_command = { 'fd', '--type', 'd', '--max-depth', '1', '--exclude', '.git' },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              local vault_path = dirs.vaults .. '/' .. selection[1]
              vim.cmd('cd ' .. vault_path)
              builtin.find_files({ cwd = vault_path })
            end
          end)
          return true
        end,
      })
    end, { buffer = true, silent = true, desc = "Z Vault" })

    -- Health check
    vim.keymap.set("n", "hc", ":checkhealth<CR>", { buffer = true, silent = true, desc = "Health Check" })

    -- Help with ?
    vim.keymap.set("n", "?", function()
      local keybindings = {
        "[fr] Files Rhodium    - Find files in ~/dev/rhodium",
        "[fR] Files Recent     - Recent files (frecency)",
        "[ff] Files            - Find files (respects .gitignore)",
        "[fa] Files All        - Find all files (includes hidden/ignored)",
        "[za] Z Academic       - Navigate to academic projects",
        "[zw] Z Professional   - Navigate to professional/work projects",
        "[zp] Z Project        - Navigate to personal projects",
        "[zs] Z Solenoid Labs  - Navigate to Solenoid Labs projects",
        "[zv] Z Vault          - Navigate to vaults",
        "[hc] Health Check     - Run :checkhealth",
        "[q]  Quit             - Exit Neovim",
        "[?]  Help             - Show this menu",
      }

      require('telescope.pickers').new({}, {
        prompt_title = 'Dashboard Shortcuts',
        finder = require('telescope.finders').new_table({
          results = keybindings,
        }),
        sorter = require('telescope.config').values.generic_sorter({}),
        layout_config = {
          width = 0.6,
          height = 0.5,
        },
      }):find()
    end, { buffer = true, silent = true, desc = "Show dashboard keybindings" })
  end,
})

require('dashboard').setup {
  theme = 'doom',
  hide = {
    statusline = false,
    tabline = true,
    winbar = true,
  },
  config = {
    header = get_logo(),
    center = {
      {
        action = function()
          require('telescope.builtin').find_files({
            prompt_title = 'Rhodium',
            cwd = dirs.rhodium,
          })
        end,
        desc = " Files Rhodium",
        icon = "⊹ ",
        key = "fr"
      },
      {
        action = function()
          require('telescope').extensions.frecency.frecency({
            prompt_title = 'Recent Files',
          })
        end,
        desc = " Files Recent",
        icon = "⊹ ",
        key = "fR"
      },
      {
        action = function()
          require('telescope.builtin').find_files({
            prompt_title = 'Files',
            hidden = false,
            no_ignore = false,
          })
        end,
        desc = " Files",
        icon = "⊹ ",
        key = "ff"
      },
      {
        action = function()
          require('telescope.builtin').find_files({
            prompt_title = 'All Files',
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = " Files All",
        icon = "⊹ ",
        key = "fa"
      },
      {
        action = function()
          local builtin = require('telescope.builtin')
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          builtin.find_files({
            prompt_title = 'Academic',
            cwd = dirs.academic,
            find_command = { 'fd', '--type', 'd', '--max-depth', '1', '--exclude', '.git' },
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local academic_path = dirs.academic .. '/' .. selection[1]
                  vim.cmd('cd ' .. academic_path)
                  builtin.find_files({ cwd = academic_path })
                end
              end)
              return true
            end,
          })
        end,
        desc = " Z Academic",
        icon = "⊹ ",
        key = "za"
      },
      {
        action = function()
          local builtin = require('telescope.builtin')
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          builtin.find_files({
            prompt_title = 'Professional',
            cwd = dirs.professional,
            find_command = { 'fd', '--type', 'd', '--max-depth', '1', '--exclude', '.git' },
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local professional_path = dirs.professional .. '/' .. selection[1]
                  vim.cmd('cd ' .. professional_path)
                  builtin.find_files({ cwd = professional_path })
                end
              end)
              return true
            end,
          })
        end,
        desc = " Z Professional",
        icon = "⊹ ",
        key = "zw"
      },
      {
        action = function()
          local builtin = require('telescope.builtin')
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          builtin.find_files({
            prompt_title = 'Projects',
            cwd = dirs.projects,
            find_command = { 'fd', '--type', 'd', '--max-depth', '2', '--exclude', '.git' },
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local project_path = dirs.projects .. '/' .. selection[1]
                  vim.cmd('cd ' .. project_path)
                  builtin.find_files({ cwd = project_path })
                end
              end)
              return true
            end,
          })
        end,
        desc = " Z Project",
        icon = "⊹ ",
        key = "zp"
      },
      {
        action = function()
          local builtin = require('telescope.builtin')
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          builtin.find_files({
            prompt_title = 'Solenoid Labs',
            cwd = dirs.solenoidlabs,
            find_command = { 'fd', '--type', 'd', '--max-depth', '2', '--exclude', '.git' },
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local solenoid_path = dirs.solenoidlabs .. '/' .. selection[1]
                  vim.cmd('cd ' .. solenoid_path)
                  builtin.find_files({ cwd = solenoid_path })
                end
              end)
              return true
            end,
          })
        end,
        desc = " Z Solenoid Labs",
        icon = "⊹ ",
        key = "zs"
      },
      {
        action = function()
          local builtin = require('telescope.builtin')
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          builtin.find_files({
            prompt_title = 'Vaults',
            cwd = dirs.vaults,
            find_command = { 'fd', '--type', 'd', '--max-depth', '1', '--exclude', '.git' },
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local vault_path = dirs.vaults .. '/' .. selection[1]
                  vim.cmd('cd ' .. vault_path)
                  builtin.find_files({ cwd = vault_path })
                end
              end)
              return true
            end,
          })
        end,
        desc = " Z Vault",
        icon = "⊹ ",
        key = "zv"
      },
      {
        action = 'checkhealth',
        desc = " Health Check",
        icon = "⊹ ",
        key = "hc"
      },
      {
        action = function()
          local keybindings = {
            "[fr] Files Rhodium    - Find files in ~/dev/rhodium",
            "[fR] Files Recent     - Recent files (frecency)",
            "[ff] Files            - Find files (respects .gitignore)",
            "[fa] Files All        - Find all files (includes hidden/ignored)",
            "[za] Z Academic       - Navigate to academic projects",
            "[zw] Z Professional   - Navigate to professional/work projects",
            "[zp] Z Project        - Navigate to personal projects",
            "[zs] Z Solenoid Labs  - Navigate to Solenoid Labs projects",
            "[zv] Z Vault          - Navigate to vaults",
            "[hc] Health Check     - Run :checkhealth",
            "[q]  Quit             - Exit Neovim",
            "[?]  Help             - Show this menu",
          }

          require('telescope.pickers').new({}, {
            prompt_title = 'Dashboard Shortcuts',
            finder = require('telescope.finders').new_table({
              results = keybindings,
            }),
            sorter = require('telescope.config').values.generic_sorter({}),
            layout_config = {
              width = 0.6,
              height = 0.5,
            },
          }):find()
        end,
        desc = " Shortcut Help",
        icon = "⊹ ",
        key = "?"
      },
    },
    footer = get_footer(),
  },
}
