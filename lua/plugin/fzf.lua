return {
  "ibhagwan/fzf-lua",
  opts = {},
  keys = {
    -- File finding
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Git Files" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },

    -- Search
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Find Word under cursor" },
    { "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep (Search)" },
    { "<leader>fb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Find in current Buffer" },

    -- Buffers & Tabs
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find Buffers" },
    { "<leader>ft", "<cmd>FzfLua tabs<cr>", desc = "Find Tabs" },

    -- Git
    { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git Commits" },
    { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git Branches" },
    { "<leader>gf", "<cmd>FzfLua git_status<cr>", desc = "Git Status (Files)" },

    -- LSP (when available)
    { "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>", desc = "LSP Definitions" },
    { "<leader>lr", "<cmd>FzfLua lsp_references<cr>", desc = "LSP References" },
    { "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
    { "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },

    -- Other useful commands
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
    { "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
    { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
    { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumps" },
    { "<leader>f/", "<cmd>FzfLua search_history<cr>", desc = "Search History" },
    { "<leader>f:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
  },
}
