require "opts"
require "launch"

-- Plugins
spec("plugin.colorscheme")
spec("plugin.treesitter")
spec("plugin.telescope")
spec("plugin.fugitive")
spec("plugin.lspconfig")

require "plugin.lazy"
require "keymaps"

require "lsp"

