{
  initLua = ''
    require("full-border"):setup {
      type = ui.Border.PLAIN,
    }

    require("git"):setup()

    THEME.git = THEME.git or {}
    THEME.git.modified = ui.Style():fg("#f9e2af")
    THEME.git.deleted = ui.Style():fg("#f38ba8")
    THEME.git.added = ui.Style():fg("#a6e3a1")
    THEME.git.updated = ui.Style():fg("#89b4fa")
    THEME.git.untracked = ui.Style():fg("#cba6f7")
    THEME.git.ignored = ui.Style():fg("#6c7086")

    THEME.git.modified_sign = "M"
    THEME.git.deleted_sign = "D"
    THEME.git.added_sign = "A"
    THEME.git.updated_sign = "U"
    THEME.git.untracked_sign = "?"
    THEME.git.ignored_sign = "!"

    require("smart-enter"):setup()
    require("chmod"):setup()

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
  '';
}
