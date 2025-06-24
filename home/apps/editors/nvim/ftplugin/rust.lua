-- Rust compilation and execution
vim.keymap.set("n", ";rb", ":term cargo build<CR>", {
	buffer = true,
	desc = "Rust: Build project",
})
vim.keymap.set("n", ";rr", ":term cargo run<CR>", {
	buffer = true,
	desc = "Rust: Run project",
})
vim.keymap.set("n", ";rs", ":split | term cargo run<CR>", {
	buffer = true,
	desc = "Rust: Run project on split term",
})
vim.keymap.set("n", ";rt", ":term cargo test<CR>", {
	buffer = true,
	desc = "Rust: Run tests",
})
vim.keymap.set("n", ";rc", ":term cargo check<CR>", {
	buffer = true,
	desc = "Rust: Check for errors (fast)",
})
vim.keymap.set("n", ";rf", ":term cargo fmt<CR>", {
	buffer = true,
	desc = "Rust: Format code",
})
