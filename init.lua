require "options"
require "launch"

-- Plugins
spec("plugin.colorscheme")
spec("plugin.treesitter")
spec("plugin.telescope")
spec("plugin.fugitive")
spec("plugin.lspconfig")
spec("plugin.oil")
spec("plugin.autopairs")

require "plugin.lazy"
require "keymaps"

require "lsp"

