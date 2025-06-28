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

-- Autoformat on save for python
autocommand('BufWritePre', {
  pattern = "?*.py",
  command = "lua vim.lsp.buf.format()",
  group = usergroup
})
