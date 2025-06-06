{ ... }:

{
  initLua = ''
          -- Full Border
          require("full-border"):setup {
            type = ui.Border.PLAIN,
          }

          -- Git
          require("git"):setup()

          function Status:git_branch_display()
            local result = Command("git"):arg({ "rev-parse", "--abbrev-ref", "HEAD" }):output()
            if result and result.status.success then
              local branch_name = string.gsub(result.stdout, "\n$", "")
              if branch_name ~= "" and branch_name ~= "HEAD" then
                return ui.Line { ui.Span("  " .. branch_name .. " ") }
              end
            end
            return ui.Line {}
          end

          function Linemode:size_and_mtime()
            local time = math.floor(self._file.cha.mtime or 0)
            if time == 0 then
              time = ""
            elseif os.date("%Y", time) == os.date("%Y") then
              time = os.date("%b %d %H:%M", time)
            else
              time = os.date("%b %d  %Y", time)
            end
            local size = self._file:size()
            return string.format("%s %s", size and ya.readable_size(size) or "-", time)
          end

          function Status:name()
            local h = self._tab.current.hovered
            if not h then return ui.Line {} end
            local linked = ""
            if h.link_to ~= nil then
              linked = " -> " .. tostring(h.link_to)
            end
            return ui.Line(" " .. h.name .. linked)
          end

          function Header:host()
            if ya.target_family() ~= "unix" then
              return ui.Line {}
            end
            return ui.Line(" " .. ya.user_name() .. "@" .. ya.host_name() .. " ")
          end

          function Header:tabs()
            local tabs = #cx.tabs
            if tabs == 1 then return ui.Line {} end
            local spans = {}
            for i = 1, tabs do
              local text = cx.tabs[i]:name() ~= "" and cx.tabs[i]:name() or i
              local style = i == cx.tabs.idx and THEME.tab_active or THEME.tab_inactive
              spans[#spans + 1] = ui.Span(" " .. text .. " "):style(style)
            end
            return ui.Line(spans)
          end

        -- Augmented Command
        -- Using the default configuration
        require("augment-command"):setup({
            prompt = false,
            default_item_group_for_prompt = "hovered",
            smart_enter = true,
            smart_paste = false,
            smart_tab_create = false,
            smart_tab_switch = false,
            confirm_on_quit = true,
            open_file_after_creation = false,
            enter_directory_after_creation = false,
            use_default_create_behaviour = false,
            enter_archives = true,
            extract_retries = 3,
            recursively_extract_archives = true,
            preserve_file_permissions = false,
            encrypt_archives = false,
            encrypt_archive_headers = false,
            reveal_created_archive = true,
            remove_archived_files = false,
            must_have_hovered_item = true,
            skip_single_subdirectory_on_enter = true,
            skip_single_subdirectory_on_leave = true,
            smooth_scrolling = false,
            scroll_delay = 0.02,
            wraparound_file_navigation = true,
        })

      -- Yatline
      require("yatline"):setup({
    	--theme = my_theme,
    	section_separator = { open = "", close = "" },
    	part_separator = { open = "", close = "" },
    	inverse_separator = { open = "", close = "" },

    	style_a = {
    		fg = "black",
    		bg_mode = {
    			normal = "white",
    			select = "brightyellow",
    			un_set = "brightred"
    		}
    	},
    	style_b = { bg = "brightblack", fg = "brightwhite" },
    	style_c = { bg = "black", fg = "brightwhite" },

    	permissions_t_fg = "green",
    	permissions_r_fg = "yellow",
    	permissions_w_fg = "red",
    	permissions_x_fg = "cyan",
    	permissions_s_fg = "white",

    	tab_width = 20,
    	tab_use_inverse = false,

    	selected = { icon = "󰻭", fg = "yellow" },
    	copied = { icon = "", fg = "green" },
    	cut = { icon = "", fg = "red" },

    	total = { icon = "󰮍", fg = "yellow" },
    	succ = { icon = "", fg = "green" },
    	fail = { icon = "", fg = "red" },
    	found = { icon = "󰮕", fg = "blue" },
    	processed = { icon = "󰐍", fg = "green" },

    	show_background = true,

    	display_header_line = true,
    	display_status_line = true,

    	component_positions = { "header", "tab", "status" },

    	header_line = {
    		left = {
    			section_a = {
              			{type = "line", custom = false, name = "tabs", params = {"left"}},
    			},
    			section_b = {
    			},
    			section_c = {
    			}
    		},
    		right = {
    			section_a = {
              			{type = "string", custom = false, name = "date", params = {"%A, %d %B %Y"}},
    			},
    			section_b = {
              			{type = "string", custom = false, name = "date", params = {"%X"}},
    			},
    			section_c = {
    			}
    		}
    	},

    	status_line = {
    		left = {
    			section_a = {
              			{type = "string", custom = false, name = "tab_mode"},
    			},
    			section_b = {
              			{type = "string", custom = false, name = "hovered_size"},
    			},
    			section_c = {
              			{type = "string", custom = false, name = "hovered_path"},
              			{type = "coloreds", custom = false, name = "count"},
    			}
    		},
    		right = {
    			section_a = {
              			{type = "string", custom = false, name = "cursor_position"},
    			},
    			section_b = {
              			{type = "string", custom = false, name = "cursor_percentage"},
    			},
    			section_c = {
              			{type = "string", custom = false, name = "hovered_file_extension", params = {true}},
              			{type = "coloreds", custom = false, name = "permissions"},
    			}
    		}
    	},
      })
  '';
}
