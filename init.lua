---------------
--- Options ---
---------------
vim.g.mapleader     = " "

vim.opt.clipboard   = "unnamedplus"
vim.opt.completeopt = "menuone,noselect,popup"
vim.opt.expandtab   = true
vim.opt.smartcase   = true
vim.opt.incsearch   = true
vim.opt.mousescroll = { "ver:1", "hor:1" }
vim.opt.number      = true
vim.opt.scrolloff   = 4
vim.opt.shiftwidth  = 2
vim.opt.softtabstop = 2
vim.opt.spell       = true
vim.opt.spelllang   = "en_us"
vim.opt.tabstop     = 2
vim.opt.undofile    = true
vim.opt.wrap        = false
vim.smartindent     = true

vim.filetype.add({
  pattern = {
    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghactions",
    [".*/synced%-files/.*%.ya?ml"] = "yaml.ghactions",
  },
})

---------------
--- Keymaps ---
---------------
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil, { desc = "Oil file browser" })

vim.keymap.set("n", "<leader>a", "<cmd>keepjumps normal! ggVG<cr>", { desc = "select all text" })

vim.keymap.set("v", ">", ">gv", { desc = "indent right while in visual mode" })
vim.keymap.set("v", "<", "<gv", { desc = "indent left while in visual mode" })

vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "comment in normal mode" })
vim.keymap.set("v", "<leader>/", "gcgv", { remap = true, desc = "comment in visual mode" })

vim.keymap.set("n", "<leader>t", ":botright terminal<CR>", { noremap = true, silent = true, desc = "open terminal" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down (wrapped lines)" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up (wrapped lines)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
vim.keymap.set("v", "H", "<gv", { desc = "move block left" })
vim.keymap.set("v", "L", ">gv", { desc = "move block right" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontally" })

vim.keymap.set("i", "<c-space>", function()
  vim.lsp.completion.get()
end, { desc = "ctrl-space show completions list" })

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<cr>", { desc = "Search files Grep" })

vim.keymap.set("n", "<leader>F", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" })

---------------
--- Plugins ---
---------------
vim.pack.add({
  { name = "nvim-autopairs", src = "https://github.com/windwp/nvim-autopairs" },
  { name = "rose-pine",      src = "https://github.com/rose-pine/nvim" },
  { name = "fzf-lua",        src = "https://github.com/ibhagwan/fzf-lua" },
  { name = "oil",            src = "https://github.com/stevearc/oil.nvim" },
})

require("nvim-autopairs").setup()
require("fzf-lua").setup()
require("oil").setup({
  skip_confirm_for_simple_edits = true,
  columns = {
    "size",
  },
  view_options = {
    show_hidden = true,
  },
  float = {
    padding = 2,
    max_width = 60,
    max_height = 30,
  },
})

-----------
--- LSP ---
-----------
vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "rust_analyzer",
  -- "actionsls",
})

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/completion") then
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end
})

-------------
--- Theme ---
-------------
require("theme")

local group = vim.api.nvim_create_augroup("CustomStatusLine", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "FileType", "TermOpen" }, {
  group = group,
  callback = function()
    vim.wo.statusline = "%{%v:lua.require('theme').statusline().render()%}"
  end,
})

-- Attaches the top winbar to files
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("jasonwoitalla/winbar", { clear = true }),
  desc = "Attach file navigation winbar",
  callback = function(args)
    if
        not vim.api.nvim_win_get_config(0).zindex         -- Not a floating window
        and vim.bo[args.buf].buftype == ""                -- Normal buffer
        and vim.api.nvim_buf_get_name(args.buf) ~= ""     -- Has a file name
        and not vim.wo[0].diff                            -- Not in diff mode
    then
      vim.wo.winbar = "%{%v:lua.require('theme').winbar().render()%}"
    end
  end,
})
