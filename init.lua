require "core.launch"

-- Plugins
spec("plugin.autopairs")
spec("plugin.colorscheme")
spec("plugin.fzf")
spec("plugin.oil")
spec("plugin.treesitter")

require "plugin.lazy"

require "config.options"
require "config.keymaps"
require "config.autocmds"

require "core.winbar"
require "core.statusline"

-- LSP (must be last)
require "core.lsp"

