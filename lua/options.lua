vim.g.mapleader = " "
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.smartindent = true

vim.opt.wrap = false
vim.opt.mousescroll = { "ver:1", "hor:1" }

-- use ctrl+l to remove highlights
vim.opt.incsearch = true
vim.opt.ignorecase = true
-- vim.opt.clipboard = "xclip"
vim.opt.undofile = true
vim.opt.scrolloff = 4
-- vim.opt.signcolumn = "yes"

-- ctrl+w d (show the diagnositics)
-- Diagnostics
vim.diagnostic.config({ virtual_text = true })

-- ctrl+n shows completion menu
-- Completions
vim.lsp.omnifunc = true
vim.opt.completeopt = { "fuzzy", "menuone", "noselect" }

