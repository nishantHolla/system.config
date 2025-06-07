local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugin = function(name)
  return function()
    require('config.plugs.' .. name)
  end
end


require('lazy').setup({
  {
    'stevearc/oil.nvim',
    config = plugin('oil')
  },

  {
    'famiu/bufdelete.nvim'
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = plugin('treesitter')
  },

  {
    'christoomey/vim-tmux-navigator',
    config = plugin('tmux')
  },

  {
    'hrsh7th/nvim-cmp',
    config = plugin('nvimCmp'),
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip'
    }
  },

  {
    'neovim/nvim-lspconfig',
    config = plugin('lsp')
  },
})
