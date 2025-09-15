vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

-- telescope keymaps
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- select all text
vim.keymap.set("n", "<leader>a", "<cmd>keepjumps normal! ggVG<cr>")

-- indent while in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- comments
vim.keymap.set("n", "<leader>/", "gcc", { remap = true })
vim.keymap.set("v", "<leader>/", "gcgv", { remap = true })

-- completions
vim.keymap.set('i', '<c-space>', function()
    vim.lsp.completion.get()
end)

