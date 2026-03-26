Status:children_add(function()
	local h = cx.active.current.hovered
	if not h then
		return ""
	end

	local spans = {}

	-- Created (birth) time
	local btime = math.floor(h.cha.btime or 0)
	if btime > 0 then
		table.insert(spans, ui.Span(" C:"):fg("#938AA9"))
		table.insert(spans, ui.Span(os.date(" %Y-%m-%d %H:%M ", btime)):fg("#C5C9C7"))
	end

	-- Modified time
	local mtime = math.floor(h.cha.mtime or 0)
	if mtime > 0 then
		table.insert(spans, ui.Span(" M:"):fg("#938AA9"))
		table.insert(spans, ui.Span(os.date(" %Y-%m-%d %H:%M ", mtime)):fg("#C5C9C7"))
	end

	return ui.Line(spans)
end, 600, Status.RIGHT)
