local usergroup = vim.api.nvim_create_augroup('UserGroup', { clear = true })
local autocommand = vim.api.nvim_create_autocmd

-- Set formatoptions
autocommand('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove({'c', 'r', 'o'})
  end,
  group = usergroup
})

-- Load view on open
autocommand('BufWinEnter', {
  pattern = '?*',
  command = 'silent! loadview',
  group = usergroup
})

-- Save view on close
autocommand('BufWinLeave', {
  pattern = '?*',
  command = 'silent! mkview',
  group = usergroup
})

-- Remove trailing whitespace
autocommand('BufWritePre', {
  pattern = '?*',
  command = [[let save_cursor = getpos(".") | %s/\s\+$//e | call setpos('.', save_cursor)]],
  group = usergroup
})

-- Autoformat on save for python and go
autocommand('BufWritePre', {
  pattern = {"?*.py", "?*.go"},
  command = "lua vim.lsp.buf.format()",
  group = usergroup
})

-- Resize splits on window resize
autocommand("VimResized", {
  pattern = "*",
  command = "wincmd =",
  group = usergroup
})

-- Indent options for Makefile
autocommand("Filetype", {
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
  end,
  group = usergroup
})
