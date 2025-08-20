require('oil').setup({
  columns = {
    'permissions',
    'size',
    'mtime',
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  watch_for_changes = true,
  keymaps = {
    ['<a-l>'] = 'actions.select',
    ['<a-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<a-h>'] = { 'actions.select', opts = { horizontal = true } },
    ['<a-t>'] = { 'actions.select', opts = { tab = true } },
    ['<a-p>'] = 'actions.preview',
    ['<leader><leader>'] = { 'actions.close', mode = 'n' },
    ['<a-r>'] = 'actions.refresh',
    ['<a-k>'] = { 'actions.parent', mode = 'n' },
    ['<a-h>'] = { 'actions.open_cwd', mode = 'n' },
    ['<a-z>'] = { 'actions.toggle_hidden', mode = 'n' },
  },
})

Key('n', '<leader><leader>', ':Oil<cr>', K_Opt('Open oil'))
vim.cmd("highlight OilDir guibg=none guifg=#a8a9eb")
