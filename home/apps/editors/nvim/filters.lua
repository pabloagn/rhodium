-- Silence nvim plugin deprecation warnings
-- --- Marks ---
vim.notify_original = vim.notify

vim.notify = function(msg, level, opts)
	if type(msg) == "string" and msg:lower():match("deprecated") then
		return
	end
	return vim.notify_original(msg, level, opts)
end
