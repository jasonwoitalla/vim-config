vim.g.mapleader = " "
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.undofile = true

vim.opt.scrolloff = 8

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })

-- Completions
vim.lsp.omnifunc = true

