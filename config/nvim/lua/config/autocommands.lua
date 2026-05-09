local usergroup = vim.api.nvim_create_augroup("UserGroup", { clear = true})
local autocommand = vim.api.nvim_create_autocmd
local utils = require("config.utils")

-- Set formatoptions
autocommand("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({'c', 'r', 'o'})
    end,
    group = usergroup,
})

-- Load view on open
autocommand("BufWinEnter", {
    pattern = "?*",
    command = "silent! loadview",
    group = usergroup,
})

-- Save view on close
autocommand("BufWinLeave", {
    pattern = "?*",
    command = "silent! mkview",
    group = usergroup,
})


-- Autoformat on save for python
autocommand('BufWritePre', {
    pattern = "?*.py",
    command = "lua vim.lsp.buf.format()",
    group = usergroup
})

-- Autoformat on save for rust
autocommand('BufWritePre', {
    pattern = "?*.rs",
    command = "lua vim.lsp.buf.format()",
    group = usergroup
})

-- Remove trailing whitespace on save
autocommand("BufWritePre", {
    pattern = '?*',
    command = [[let save_cursor = getpos(".") | %s/\s\+$//e | call setpos('.', save_cursor)]],
    group = usergroup,
})

-- Resize splits on window resize
autocommand("VimResized", {
    pattern = "*",
    command = "wincmd =",
    group = usergorup,
})

-- Indent option for Makefile
autocommand("Filetype", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 0
    end,
    group = usergroup,
})

-- Winbar with the file name
autocommand("BufWinEnter", {
    callback = function()
        vim.wo.winbar = utils.winbar_text()
    end,
    group = usergroup,
})
