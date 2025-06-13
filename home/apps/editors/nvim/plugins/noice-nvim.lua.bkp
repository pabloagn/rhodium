require("noice").setup({
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },

    views = {
      notify = {
        backend = "notify",
        replace = true,
        merge = true,
      },
      mini = {
        backend = "mini",
        border = {
          style = "none", -- No border
        },
        position = {
          row = -2,
          col = "100%",
        },
        win_options = {
          winblend = 0,
        },
      },
      cmdline_popup = {
        border = {
          style = "none", -- No border
        },
        win_options = {
          winblend = 0,
        },
      },
      popupmenu = {
        border = {
          style = "none", -- No border
        },
        win_options = {
          winblend = 0,
        },
      },
    },
  },
  keys = {
    { "<leader>sn",  "",                                                                            desc = "+noice" },
    { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                              desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end,                                   desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,                           expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
    { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,                           expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
  },
  config = function(_, opts)
    -- HACK: Noice shows messages from before it was enabled,
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)

    -- Set highlight groups for clean solid background (like dunst)
    -- Using a dark background color similar to dunst
    local bg_color = "#1a1b26"   -- Adjust this to match your theme
    local text_color = "#c0caf5" -- Adjust this to match your theme

    vim.api.nvim_set_hl(0, "NoicePopup", { bg = bg_color, fg = text_color })
    vim.api.nvim_set_hl(0, "NoiceMini", { bg = bg_color, fg = text_color })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = bg_color, fg = text_color })
    vim.api.nvim_set_hl(0, "NoicePopupmenu", { bg = bg_color, fg = text_color })
    vim.api.nvim_set_hl(0, "NoiceConfirm", { bg = bg_color, fg = text_color })

    -- For the mini view (the notification that appears)
    vim.api.nvim_set_hl(0, "NoiceFormatProgressDone", { bg = bg_color, fg = text_color })
    vim.api.nvim_set_hl(0, "NoiceFormatProgressTodo", { bg = bg_color, fg = text_color })
    vim.api.nvim_set_hl(0, "NoiceLspProgressTitle", { bg = bg_color, fg = text_color })

    -- Override floating window highlights to ensure solid background
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_color, fg = text_color })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg_color, fg = bg_color }) -- Hide border by matching bg
  end,
})

-- require("noice").setup({
--
--   event = "VeryLazy",
--   opts = {
--     lsp = {
--       override = {
--         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--         ["vim.lsp.util.stylize_markdown"] = true,
--         ["cmp.entry.get_documentation"] = true,
--       },
--     },
--     routes = {
--       {
--         filter = {
--           event = "msg_show",
--           any = {
--             { find = "%d+L, %d+B" },
--             { find = "; after #%d+" },
--             { find = "; before #%d+" },
--           },
--         },
--         view = "mini",
--       },
--     },
--     presets = {
--       bottom_search = true,
--       command_palette = true,
--       long_message_to_split = true,
--     },
--   },
--   -- stylua: ignore
--   keys = {
--     { "<leader>sn", "", desc = "+noice"},
--     { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
--     { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
--     { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
--     { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
--     { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
--     { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
--     { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
--     { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
--   },
--   config = function(_, opts)
--     -- HACK: Noice shows messages from before it was enabled,
--     if vim.o.filetype == "lazy" then
--       vim.cmd([[messages clear]])
--     end
--     require("noice").setup(opts)
--   end,
-- })
--
