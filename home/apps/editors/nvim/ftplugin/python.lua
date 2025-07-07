-- Python development
vim.keymap.set("n", ";pr", ":!python %<CR>", {
	buffer = true,
	desc = "Python: Run current file",
})

vim.keymap.set("n", ";pt", ":!python -m pytest %<CR>", {
	buffer = true,
	desc = "Python: Run pytest on current file",
})

-- --- Jupyter Notebooks ---
-- Only load for Jupyter notebooks or Python files with cells
if not (vim.fn.expand("%:e") == "ipynb" or vim.fn.search("^# %%", "nw") > 0) then
  return
end

-- Molten keybindings
vim.keymap.set("n", ";mi", ":MoltenInit<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Initialize",
})

vim.keymap.set("n", ";e", ":MoltenEvaluateOperator<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Evaluate operator",
})

vim.keymap.set("n", ";rl", ":MoltenEvaluateLine<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Evaluate line",
})

vim.keymap.set("n", ";rr", ":MoltenReevaluateCell<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Re-evaluate cell",
})

vim.keymap.set("v", ";r", ":<C-u>MoltenEvaluateVisual<CR>gv", {
	buffer = true,
	silent = true,
	desc = "Molten: Evaluate visual",
})

vim.keymap.set("n", ";rd", ":MoltenDelete<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Delete cell",
})

vim.keymap.set("n", ";oh", ":MoltenHideOutput<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Hide output",
})

vim.keymap.set("n", ";os", ":noautocmd MoltenEnterOutput<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Show output",
})

vim.keymap.set("n", ";x", ":MoltenInterrupt<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Interrupt execution",
})

vim.keymap.set("n", ";i", ":MoltenInfo<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Show info",
})
