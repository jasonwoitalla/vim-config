vim.opt.nu = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.smartindent = true

vim.opt.wrap = false
vim.opt.mousescroll = { "ver:1", "hor:1" }

-- use ctrl+l to remove highlights
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.scrolloff = 4

-- spell check
-- z= this will suggest spell fixes
-- zg this will add the word to my dictionary
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- ctrl+n shows completion menu
-- Completions
vim.cmd[[set completeopt+=menuone,noselect,popup]]

-- filetypes
vim.filetype.add({
    pattern = {
        [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghactions",
        [".*/synced%-files/.*%.ya?ml"] = "yaml.ghactions",
    },
})
