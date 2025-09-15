local M = {
    "rose-pine/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local colors = {
            bright_white = '#FFFFFF',
            error_red = '#DB5355',
            warn_yellow = '#F6E07D',
        }

        local statusline_groups = {}
        for mode, color in pairs {
            Normal = 'iris',
            Pending = 'pine',
            Visual = 'gold',
            Insert = 'foam',
            Command = 'love',
            Other = 'rose',
        } do
            statusline_groups['StatuslineMode' .. mode] = { fg = 'surface', bg = color }
            statusline_groups['StatuslineModeSeparator' .. mode] = { fg = color, bg = 'surface' }
        end

        statusline_groups = vim.tbl_extend('error', statusline_groups, {
            StatuslineItalic = { fg = 'subtle', bg = 'surface', italic = true },
            StatuslineTitle = { fg = colors.bright_white, bg = 'surface', bold = true },
            DiagnosticError = { fg = colors.error_red },
            DiagnosticWarn = { fg = colors.warn_yellow },
            DiagnosticHint = { fg = 'iris' },
            DiagnosticInfo = { fg = 'pine' }
        })

        local winbar_groups = {
            WinBar = { fg = 'subtle', bg = 'surface' },
            WinBarNC = { bg = 'surface' },
            WinBarDir = { fg = 'love', bg = 'surface', italic = true },
            WinBarSeparator = { fg = 'foam', bg = 'surface' }
        }

        local hl_groups = vim.tbl_extend('error', statusline_groups, winbar_groups)

        require('rose-pine').setup({
            variant = 'main',
            dark_variant = 'main',

            highlight_groups = hl_groups
        })

	    vim.cmd("colorscheme rose-pine")
    end
}

return M


