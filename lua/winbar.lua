local icons = require 'icons'

local M = {}

function M.render()
    local path = vim.fs.normalize(vim.fn.expand '%:p')

    if vim.startswith(path, 'diffview') then
        return string.format('%#Winbar#%s', path)
    end

    local separator = '%#WinbarSeparator# > '

    local prefix, prefix_path = '', ''

    -- If the window is too small, shorten the path
    if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
        path = vim.fn.pathshorten(path)
    else
        local special_dirs = {
            HOME = '/home/c080616',
            CODE = '/home/c080616/code',
            DISTRIBUTION_DEDICATED_PLANNING = '/home/c080616/code/distribution-dedicated-planning',
            DISTRIBUTION_ADVICE_CLIENT_TAX = '/home/c080616/code/distribution-advice-client-tax',
        }

        for dir_name, dir_path in pairs(special_dirs) do
            if vim.startswith(path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path and prefix == '' then
                prefix, prefix_path = dir_name, dir_path
            end
        end

        if prefix ~= '' then
            path = path:gsub('^' .. prefix_path, '')
            prefix = string.format('%%#WinBarDir#%s %s%s', icons.developer['folder'], prefix, separator)
        end
    end

    path = path:gsub('^/', '')

    return table.concat {
        ' ',
        prefix,
        table.concat(
            vim.iter(vim.split(path, '/'))
                :map(function(segment)
                    return string.format('%%#Winbar#%s', segment)
                end)
                :totable(),
            separator
        ),
    }
end

return M

