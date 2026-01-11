-- Additional plugin initializations for expert-level Yazi setup

-- Override Tabs.height to always show tab bar, even with single tab
function Tabs.height()
	return 1
end

-- Relative motions plugin setup (vim-like number motions)
require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
})

-- Jump-to-char plugin setup
require("jump-to-char"):setup({
	-- Default settings work well
})

-- Compress plugin setup
require("compress"):setup({
	-- Default archive format
	default_format = "zip",
	-- Available formats: zip, tar.gz, tar.bz2, tar.xz, 7z
})

-- Ouch plugin setup (archive preview/extract)
require("ouch"):setup({
	-- Show archive contents in preview
})

-- Lazygit plugin setup
require("lazygit"):setup({
	-- Use floating window
})

-- Mediainfo plugin setup
require("mediainfo"):setup({
	-- Show detailed media information
})

-- Smart-paste plugin setup
require("smart-paste"):setup({
	-- Paste into directory when hovering over it
})

-- Projects plugin setup
require("projects"):setup({
	-- Store projects in XDG data directory
	save_path = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share") .. "/yazi/projects.json",
})

-- Mime-ext plugin setup (fast MIME type detection)
require("mime-ext"):setup({
	-- Use extension-based MIME detection for speed
	with_files = false, -- Don't fallback to file(1) command
})

-- Toggle-pane plugin setup
require("toggle-pane"):setup({
	-- Default toggle behavior
})
