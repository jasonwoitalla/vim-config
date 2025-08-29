vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- telescope keymaps
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

