-----------------------------------------------------------
-- Route:............system/interface/fonts.nix
-- Type:.............Module
-- Created by:.......Pablo Aguirre
-----------------------------------------------------------

local wezterm = require 'wezterm'
local config = {}

local mux = wezterm.mux
local act = wezterm.action

-- Set color scheme
-- config.color_scheme = 'Azu (Gogh)'
-- config.color_scheme = 'Tokyo Night Moon'
-- config.color_scheme = 'tokyonight'
-- config.color_scheme = 'Vesper'
config.color_scheme = 'Pulp (terminal.sexy)'
-- config.color_scheme = 'Rouge 2'
-- config.color_scheme = 'Sea Shells (Gogh)'
-- config.color_scheme = 'Sequoia Monochrome'
-- config.color_scheme = 'Sequoia Moonlight'
-- config.color_scheme = 'Spacegray (Gogh)'

-- Set font and size
config.font = wezterm.font('Fira Code')
config.font_size = 12

-- Set resolution
config.dpi = 96

-- Set cursor style to a thicker blinking bar and make it blink faster
config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 200 -- Blink rate in milliseconds

-- Key bindings for copy and paste
config.keys = {
  { key = 'C', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
}

-- Mouse bindings
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },
}

-- Adjust text color brightness
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}

-- Set a solid background color with transparency
config.window_background_opacity = 0.9
--config.win32_system_backdrop = "Acrylic"

-- Tab options
config.use_fancy_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }

-- Additional options
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.check_for_updates = false

-- Crucial for this to be disabled in order to work on hyprland
config.enable_wayland = false

return config
