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
  '';
}
