vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'BufWritePost', 'User', 'DirChanged', 'BufReadPost' }, {
    group = vim.api.nvim_create_augroup('jasonwoitalla/git_branch', { clear = true }),
    desc = 'Save git branch to variable',
    pattern = { '*', 'FugitiveChanged', 'OilEnter' },
    callback = function()
        local branch = vim.fn.system('git branch --show-current 2> /dev/null | tr -d \'\n\'')
        vim.b.branch_name = branch
    end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
    group = vim.api.nvim_create_augroup('jasonwoitalla/winbar', { clear = true }),
    desc = 'Attach file navigation winbar',
    callback = function(args)
        if
            not vim.api.nvim_win_get_config(0).zindex -- Not a floating window
            and vim.bo[args.buf].buftype == '' -- Normal buffer
            and vim.api.nvim_buf_get_name(args.buf) ~= '' -- Has a file name
            and not vim.wo[0].diff -- Not in diff mode
        then
            vim.wo.winbar = "%{%v:lua.require'winbar'.render()%}"
        end
    end,
})

