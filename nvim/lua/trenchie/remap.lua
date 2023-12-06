local builtin = require('telescope.builtin')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fr", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set("n", "<leader>pp", function()
	vim.cmd("PackerSync")
end)
vim.keymap.set("n", "<leader>pc", function()
	vim.cmd("lua FixMyColors()")
end)
