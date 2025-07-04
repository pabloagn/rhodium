local lualine = require('lualine')

local colors = require("kanso.colors").setup()

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,

  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,

  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Theme
local config = {
  options = {
    globalstatus = vim.o.laststatus == 3,
    disabled_filetypes = {
      statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
      winbar = { "dashboard", "alpha", "ministarter", "snacks_dashboard" }
    },
    component_separators = '',
    section_separators = '',
    theme = {
      normal = {
        c = { fg = colors.fg, bg = colors.bg }
      },
      inactive = {
        c = { fg = colors.fg_dark, bg = colors.bg_dark }
      },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- Rhodium
ins_left {
  function()
    return 'Rh'
  end,
  color = { fg = "#090E13", bg = "#c4746e" },
  padding = { left = 1, right = 1 },
}

-- Modes
ins_left {
  function()
    local mode_map = {
      n      = 'NOR',
      i      = 'INS',
      v      = 'VIS',
      ['']   = 'VBL',
      V      = 'VLN',
      c      = 'CMD',
      no     = 'OPR',
      s      = 'SEL',
      S      = 'SLN',
      ic     = 'ICM',
      R      = 'RPL',
      Rv     = 'VRP',
      cv     = 'VEX',
      ce     = 'EXN',
      r      = 'HIT',
      rm     = 'MOR',
      ['r?'] = 'CON',
      ['!']  = 'SHL',
      t      = 'TRM',
    }
    return mode_map[vim.fn.mode()] or 'UNK'
  end,
  color = function()
    local mode_color = {
      n = { fg = colors.bg, bg = colors.green },
      i = { fg = colors.bg, bg = colors.blue },
      v = { fg = colors.bg, bg = colors.yellow },
      [''] = { fg = colors.bg, bg = colors.yellow },
      V = { fg = colors.bg, bg = colors.yellow },
      c = { fg = colors.bg, bg = colors.red },
      no = { fg = colors.bg, bg = colors.green },
      s = { fg = colors.bg, bg = colors.comment },
      S = { fg = colors.bg, bg = colors.comment },
      ic = { fg = colors.bg, bg = colors.blue },
      R = { fg = colors.bg, bg = colors.red },
      Rv = { fg = colors.bg, bg = colors.red },
      cv = { fg = colors.bg, bg = colors.red },
      ce = { fg = colors.bg, bg = colors.red },
      r = { fg = colors.bg, bg = colors.comment },
      rm = { fg = colors.bg, bg = colors.comment },
      ['r?'] = { fg = colors.bg, bg = colors.comment },
      ['!'] = { fg = colors.bg, bg = colors.red },
      t = { fg = colors.bg, bg = colors.green },
    }
    return mode_color[vim.fn.mode()] or { fg = colors.bg, bg = colors.fg }
  end,
  padding = { left = 1, right = 1 },
}

-- File info
ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.fg },
  symbols = {
    modified = '●',
    readonly = '◯',
    unnamed = '∅',
  },
  path = 1,   -- Show relative path
  shorting_target = 20,
  padding = { left = 1 },
}

ins_left {
  function()
    return '│'
  end,
  color = { fg = colors.bg_highlight },
  padding = { left = 1 },
}

ins_left {
  'filesize',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.comment },
  padding = { left = 1, right = 0 },
}

-- Progress (Row:Col)
ins_left {
  'location',
  color = { fg = colors.fg_dark },
  fmt = function(str)
    return str:gsub(':', '∶')
  end,
  padding = { left = 1, right = 0 },
}

-- Progress - Percentage and total lines
ins_left {
  color = { fg = colors.comment },
  function()
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    local percentage = math.floor((current_line / total_lines) * 100)
    return percentage .. '%% ' .. total_lines
  end,
  padding = { left = 1, right = 0 },
}

ins_left {
  function()
    return '│'
  end,
  color = { fg = colors.bg_highlight },
  padding = { left = 1, right = 0 },
}

-- Diagnostics
ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = {
    error = '● ',
    warn = '● ',
    info = '● ',
    hint = '● '
  },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.blue },
    hint = { fg = colors.comment },
  },
  always_visible = false,
  padding = { left = 1, right = 0 },
}

-- Buffer count
ins_left {
  function()
    local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
    return '■ ' .. buf_count
  end,
  color = { fg = colors.comment },
  padding = { left = 1, right = 1 },
}

-- Center spacing
ins_left {
  function()
    return '%='
  end,
}

-- LSP status with accent when active
ins_left {
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return '∅ LSP'
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return '▶ ' .. client.name:upper()
      end
    end
    return '∅ LSP'
  end,
  color = function()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return { fg = colors.comment }
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return { fg = colors.green }
      end
    end
    return { fg = colors.comment }
  end,
  padding = { left = 1, right = 1 },
}

-- Right side separator
ins_right {
  function()
    return '│'
  end,
  color = { fg = colors.bg_highlight },
  padding = { left = 1, right = 1 },
}

-- Git branch with accent when in repo
ins_right {
  'branch',
  icon = '',
  color = { fg = colors.green },
  cond = conditions.check_git_workspace,
  fmt = function(str)
    if #str > 20 then
      return str:sub(1, 17) .. '…'
    end
    return str
  end,
}

-- Git diff
ins_right {
  'diff',
  symbols = {
    added = '▲ ',
    modified = '▼ ',
    removed = '◆ '
  },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
  padding = { left = 1 },
}

-- Technical details separator
ins_right {
  function()
    return '│'
  end,
  color = { fg = colors.bg_highlight },
  padding = { left = 1, right = 1 },
}

-- Encoding info
ins_right {
  'encoding',
  fmt = function(str)
    return str:upper()
  end,
  cond = conditions.hide_in_width,
  color = { fg = colors.comment },
}

-- File format
ins_right {
  'fileformat',
  fmt = function(str)
    local format_map = {
      unix = 'UNIX',
      dos = 'DOS',
      mac = 'MAC'
    }
    return format_map[str] or str:upper()
  end,
  icons_enabled = false,
  color = { fg = colors.comment },
  -- padding = { left = 1 },
}

-- Filetype with accent for active files
ins_right {
  'filetype',
  icons_enabled = false,
  color = { fg = colors.green },
  fmt = function(str)
    return str:upper()
  end,
  padding = { left = 1 },
}

-- End marker
ins_right {
  function()
    return '█'
  end,
  color = { fg = colors.green },
  padding = { left = 1, right = 0 },
}

lualine.setup(config)
