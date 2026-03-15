-- Oil.nvim file browser
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

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

-- terminal
vim.keymap.set('n', '<leader>t', ':botright terminal<CR>', { noremap = true, silent = true })

-- ========== ADDITIONAL USEFUL KEYMAPS ==========

-- Window navigation (faster than <C-w> + hjkl)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left window" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to bottom window" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to top window" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right window" })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete buffer" })

-- Better line movements
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down (wrapped lines)" })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up (wrapped lines)" })

-- Move lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move block up" })
vim.keymap.set('v', 'H', "<gv", { desc = "move block left" })
vim.keymap.set('v', 'L', ">gv", { desc = "move block right" })

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Scroll down (centered)" })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Scroll up (centered)" })
vim.keymap.set('n', 'n', 'nzzzv', { desc = "Next search result (centered)" })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = "Previous search result (centered)" })

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Clear search highlights" })

-- Paste without yanking in visual mode
vim.keymap.set('x', '<leader>p', '"_dP', { desc = "Paste without yanking" })

-- Delete to void register
vim.keymap.set({'n', 'v'}, '<leader>d', '"_d', { desc = "Delete to void register" })

-- Quick save and quit
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = "Save file" })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = "Quit" })
vim.keymap.set('n', '<leader>Q', '<cmd>qa!<CR>', { desc = "Force quit all" })

-- Split windows
vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = "Split vertically" })
vim.keymap.set('n', '<leader>sh', '<cmd>split<CR>', { desc = "Split horizontally" })

-- Better escape from insert mode
vim.keymap.set('i', 'jk', '<Esc>', { desc = "Exit insert mode" })
vim.keymap.set('i', 'kj', '<Esc>', { desc = "Exit insert mode" })
