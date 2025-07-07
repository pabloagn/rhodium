-- Initialize
vim.keymap.set("n", ";mi", ":MoltenInit<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Initialize plugin",
})

-- Evaluation
vim.keymap.set("n", ";e", ":MoltenEvaluateOperator<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Evaluate operator selection",
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
	desc = "Molten: Evaluate visual selection",
})

-- Cell management
vim.keymap.set("n", ";rd", ":MoltenDelete<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Delete cell",
})

-- Output control
vim.keymap.set("n", ";oh", ":MoltenHideOutput<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Hide output",
})

vim.keymap.set("n", ";os", ":noautocmd MoltenEnterOutput<CR>", {
	buffer = true,
	silent = true,
	desc = "Molten: Show/enter output",
})
