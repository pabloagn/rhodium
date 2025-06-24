-- Rust compilation and execution
vim.keymap.set("n", ";rb", ":!cargo build<CR>", {
	buffer = true,
	desc = "Rust: Build project",
})
vim.keymap.set("n", ";rr", ":!cargo run<CR>", {
	buffer = true,
	desc = "Rust: Run project",
})
vim.keymap.set("n", ";rt", ":!cargo test<CR>", {
	buffer = true,
	desc = "Rust: Run tests",
})
vim.keymap.set("n", ";rc", ":!cargo check<CR>", {
	buffer = true,
	desc = "Rust: Check for errors (fast)",
})
vim.keymap.set("n", ";rf", ":!cargo fmt<CR>", {
	buffer = true,
	desc = "Rust: Format code",
})
