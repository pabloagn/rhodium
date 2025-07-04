require("yatline"):setup({
	section_separator = { open = "", close = "" },
	part_separator = { open = "│", close = "│" },
	inverse_separator = { open = "", close = "" },

	style_a = {
		fg = "black",
		bg_mode = {
			normal = "white",
			select = "white",
			un_set = "white",
		},
	},

	style_b = {
		fg = "black",
		bg = "red",
	},

	style_c = {
		fg = "white",
		bg = "black",
	},

	permissions_t_fg = "green",
	permissions_r_fg = "yellow",
	permissions_w_fg = "red",
	permissions_x_fg = "cyan",
	permissions_s_fg = "white",

	tab_width = 20,
	tab_use_inverse = false,

	selected = { icon = "●", fg = "yellow" },
	copied = { icon = "◌", fg = "green" },
	cut = { icon = "⌀", fg = "red" },

	total = { icon = "󰮍", fg = "yellow" },
	succ = { icon = "", fg = "green" },
	fail = { icon = "", fg = "red" },
	found = { icon = "󰮕", fg = "blue" },
	processed = { icon = "󰐍", fg = "green" },

	show_background = false,
	display_header_line = true,
	display_status_line = true,

	component_positions = { "header", "tab", "status" },

	header_line = {
		left = {
			section_a = {
				{
					type = "line",
					custom = false,
					name = "tabs",
					params = { "left" },
				},
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {},
			section_b = {
				{
					type = "string",
					custom = true,
					name = "Rh",
				},
			},
			section_c = {
				{
					type = "string",
					custom = false,
					name = "tab_mode",
				},
				{
					type = "string",
					custom = false,
					name = "hovered_size",
				},
				{
					type = "string",
					custom = false,
					name = "hovered_path",
				},
				{
					type = "coloreds",
					custom = false,
					name = "count",
				},
			},
		},
		right = {
			section_a = {},
			section_b = {},
			section_c = {
				{
					type = "string",
					custom = false,
					name = "cursor_position",
				},
				{
					type = "string",
					custom = false,
					name = "cursor_percentage",
				},
				{
					type = "string",
					custom = false,
					name = "hovered_file_extension",
					params = { true },
				},
				{
					type = "coloreds",
					custom = false,
					name = "permissions",
				},
			},
		},
	},
})


