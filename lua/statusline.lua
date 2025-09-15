-- Based on: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/statusline.lua
local icons = require 'icons'

local M = {}

-- Don't show the command that produced the quickfix list
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead
vim.o.showmode = false

function M.mode_component()
    local mode_to_str = {
        ['n'] = 'NORMAL',
        ['no'] = 'OP-PENDING',
        ['nov'] = 'OP-PENDING',
        ['noV'] = 'OP-PENDING',
        ['no\22'] = 'OP-PENDING',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['ntT'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL',
        ['Vs'] = 'VISUAL',
        ['\22'] = 'VISUAL',
        ['\22s'] = 'VISUAL',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT',
        ['\19'] = 'SELECT',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rv'] = 'VIRT REPLACE',
        ['Rvc'] = 'VIRT REPLACE',
        ['Rvx'] = 'VIRT REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }

    local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

    local hl = 'Other'
    if mode:find 'NORMAL' then
        hl = 'Normal'
    elseif mode:find 'PENDING' then
        hl = 'Pending'
    elseif mode:find 'VISUAL' then
        hl = 'Visual'
    elseif mode:find 'INSERT' or mode:find 'SELECT' then
        hl = 'Insert'
    elseif mode:find 'COMMAND' or mode:find 'TERMINAL' or mode:find 'EX' then
        hl = 'Command'
    end

    return table.concat {
        string.format('%%#StatuslineModeSeparator%s#', hl),
        string.format('%%#StatuslineMode%s#%s', hl, mode),
        string.format('%%#StatuslineModeSeparator%s#', hl)
    }
end

function M.git_component()
    local branch_name = vim.b.branch_name
    return string.format('%%#StatuslineTitle#%s %s', icons.developer['git'], branch_name)
end

local last_diagnostic_component = '' -- Diagnostic cache for insert mode
function M.diagnostics_component()
    if vim.bo.filetype == 'lazy' then
        return ''
    end

    if vim.startswith(vim.api.nvim_get_mode().mode, 'i') then
        return last_diagnostic_component
    end

    local severity_init = {
        ERROR = 0,
        WARN = 0,
        HINT = 0,
        INFO = 0,
    }

    local counts = vim.iter(vim.diagnostic.get(0)):fold(severity_init, function(acc, diagnostic)
        local severity = vim.diagnostic.severity[diagnostic.severity]
        acc[severity] = acc[severity] + 1
        return acc
    end)

    local parts = vim.iter(counts)
        :map(function(severity, count)
            if count == 0 then
                return nil
            end

            local hl = 'Diagnostic' .. severity:sub(1, 1) .. severity:sub(2):lower()
            return string.format('%%#%s#%s %d', hl, icons.diagnostics[severity], count)
        end)
        :totable()

    local component = table.concat(parts, ' ')
    last_diagnostic_component = component
    return component
end

function M.filetype_component()
    local filetype = vim.bo.filetype
    if filetype == '' then
        filetype = '[No Name]'
    end
    local icon = icons.filetype[filetype]
    if icon == nil then
        icon = ''
    end
    return string.format('%%#StatuslineTitle#%s%s', icon, filetype)
end

function M.encoding_component()
    local encoding = vim.opt.fileencoding:get()
    return encoding ~= '' and string.format('%%#StatuslineModeSeparatorOther#%s', encoding) or ''
end

function M.position_component()
    local line = vim.fn.line '.'
    local line_count = vim.api.nvim_buf_line_count(0)
    local col = vim.fn.virtcol '.'

    return table.concat {
        '%#StatuslineItalic#l: ',
        string.format('%%#StatuslineTitle#%d', line),
        string.format('%%#StatuslineItalic#/%d c: %d', line_count, col)
    }
end

function M.render()
    local function concat_components(components)
        return vim.iter(components):skip(1):fold(components[1], function(acc, component)
            return #component > 0 and string.format('%s    %s', acc, component) or acc
        end)
    end

    return table.concat {
        concat_components {
            M.mode_component(),
            M.git_component(),
        },
        '%#StatusLine#%=',
        concat_components {
            M.diagnostics_component(),
            M.filetype_component(),
            M.encoding_component(),
            M.position_component(),
        },
        ' ',
    }
end

vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M

