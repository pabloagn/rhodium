local lualine = require('lualine')

-- Sacred computer monochrome palette - brutalist aesthetic
local colors = {
  bg       = '#1a1a1a',
  fg       = '#ffffff',
  gray0    = '#0f0f0f',
  gray1    = '#262626',
  gray2    = '#3a3a3a',
  gray3    = '#4e4e4e',
  gray4    = '#626262',
  gray5    = '#767676',
  gray6    = '#8a8a8a',
  gray7    = '#9e9e9e',
  gray8    = '#b2b2b2',
  gray9    = '#c6c6c6',
  white    = '#ffffff',
  accent   = '#505050',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 100
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Brutalist theme - no decorative nonsense
local config = {
  options = {
    component_separators = '',
    section_separators = '',
    globalstatus = true,
    theme = {
      normal = { 
        c = { fg = colors.fg, bg = colors.bg }
      },
      inactive = { 
        c = { fg = colors.gray6, bg = colors.gray1 }
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

-- Left side: Essential information only
ins_left {
  function()
    return '█'
  end,
  color = { fg = colors.white, bg = colors.bg },
  padding = { left = 0, right = 1 },
}

ins_left {
  function()
    local mode_map = {
      n      = 'NOR',
      i      = 'INS',
      v      = 'VIS',
      [''] = 'VBL',
      V      = 'VLN',
      c      = 'CMD',
      no     = 'OPR',
      s      = 'SEL',
      S      = 'SLN',
      [''] = 'SBL',
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
  color = { fg = colors.bg, bg = colors.white },
  padding = { left = 1, right = 1 },
}

ins_left {
  function()
    return '▐'
  end,
  color = { fg = colors.gray3, bg = colors.bg },
  padding = { left = 0, right = 1 },
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.white },
  symbols = {
    modified = '●',
    readonly = '◯',
    unnamed = '∅',
  },
  padding = { right = 1 },
}

ins_left {
  'filesize',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.gray7 },
  fmt = function(str)
    return str:upper()
  end,
}

ins_left {
  function()
    return '▎'
  end,
  color = { fg = colors.gray2 },
  padding = { left = 1, right = 1 },
}

ins_left {
  'location',
  color = { fg = colors.gray8 },
  fmt = function(str)
    return str:gsub(':', '∶')
  end,
}

ins_left {
  'progress',
  color = { fg = colors.gray6 },
  fmt = function(str)
    return str:gsub('%%', '∥')
  end,
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { 
    error = '◆', 
    warn = '◇', 
    info = '◯', 
    hint = '▫'
  },
  diagnostics_color = {
    error = { fg = colors.white },
    warn = { fg = colors.gray7 },
    info = { fg = colors.gray6 },
    hint = { fg = colors.gray5 },
  },
  always_visible = false,
  padding = { left = 1 },
}

-- Center spacing
ins_left {
  function()
    return '%='
  end,
}

-- LSP status - professional presentation
ins_left {
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
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
  color = { fg = colors.gray8 },
  padding = { left = 1, right = 1 },
}

-- Right side: Technical details
ins_right {
  function()
    return '▎'
  end,
  color = { fg = colors.gray2 },
  padding = { left = 1, right = 1 },
}

ins_right {
  'branch',
  icon = '◊',
  color = { fg = colors.gray7 },
  cond = conditions.check_git_workspace,
  fmt = function(str)
    if #str > 20 then
      return str:sub(1, 17) .. '…'
    end
    return str:upper()
  end,
}

ins_right {
  'diff',
  symbols = { 
    added = '▲', 
    modified = '▼', 
    removed = '◆' 
  },
  diff_color = {
    added = { fg = colors.gray8 },
    modified = { fg = colors.gray6 },
    removed = { fg = colors.gray4 },
  },
  cond = conditions.hide_in_width,
  padding = { left = 1 },
}

ins_right {
  function()
    return '▐'
  end,
  color = { fg = colors.gray3 },
  padding = { left = 1, right = 1 },
}

ins_right {
  'encoding',
  fmt = function(str)
    return str:upper()
  end,
  cond = conditions.hide_in_width,
  color = { fg = colors.gray7 },
}

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
  color = { fg = colors.gray7 },
  padding = { left = 1 },
}

ins_right {
  function()
    return '█'
  end,
  color = { fg = colors.white },
  padding = { left = 1, right = 0 },
}

lualine.setup(config)
