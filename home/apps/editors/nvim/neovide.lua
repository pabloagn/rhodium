if vim.g.neovide then

	-- Transparent background
	vim.g.neovide_opacity = 0.0
	vim.g.neovide_normal_opacity = 0.0

	-- Animation settings
	vim.g.neovide_cursor_animation_length = 0.08
	vim.g.neovide_cursor_trail_size = 0.5
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_unfocused_outline_width = 0.125
  
	-- Cursor particles
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_density = 7.0
	vim.g.neovide_cursor_vfx_particle_speed = 10.0

	-- Window behavior
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_profiler = false

	-- Input settings
	vim.g.neovide_touch_deadzone = 6.0
	vim.g.neovide_touch_drag_timeout = 0.17

	-- Scroll settings
	vim.g.neovide_scroll_animation_length = 0.3

	-- Refresh rate
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5

	-- Confirm quit
	vim.g.neovide_confirm_quit = true

	-- Fullscreen
	vim.g.neovide_fullscreen = false

	-- Scale factor
	vim.g.neovide_scale_factor = 1.0

	-- Padding
	vim.g.neovide_padding_top = 8
	vim.g.neovide_padding_bottom = 8
	vim.g.neovide_padding_right = 8
	vim.g.neovide_padding_left = 8
  
	-- Floating blur
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	  
	-- Floating shadow
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	  
	-- Hide mouse when typing
	vim.g.neovide_hide_mouse_when_typing = true
	  
	-- Underline automatic scaling
	vim.g.neovide_underline_automatic_scaling = false
	  
	-- Theme
	vim.g.neovide_theme = 'auto'
  
	-- Key mappings for Neovide-specific features
	vim.keymap.set('n', '<F11>', function()
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
	end, { desc = 'Toggle fullscreen' })
  
	vim.keymap.set('n', '<C-+>', function()
	  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
	end, { desc = 'Increase scale' })
	  
	vim.keymap.set('n', '<C-->', function()
	  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 0.9
	end, { desc = 'Decrease scale' })
	  
	vim.keymap.set('n', '<C-0>', function()
	  vim.g.neovide_scale_factor = 1.0
	end, { desc = 'Reset scale' })
end
