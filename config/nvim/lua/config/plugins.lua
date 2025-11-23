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
    config = plugin('oil'),
    event = "VeryLazy"
  },

  {
    'famiu/bufdelete.nvim',
    event = "VeryLazy"
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = plugin('treesitter')
  },

  {
    'christoomey/vim-tmux-navigator',
    config = plugin('tmux'),
    event = "VeryLazy"
  },

  {
    'hrsh7th/nvim-cmp',
    config = plugin('nvim_cmp'),
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip'
    },
    event = "VeryLazy"
  },

  {
    'neovim/nvim-lspconfig',
    config = plugin('lsp')
  },

  {
    'numToStr/Comment.nvim',
    config = plugin('comment'),
    event = "VeryLazy"
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = plugin('indentline')
  },

  {
    'loctvl842/monokai-pro.nvim',
    config = plugin('monokai')
  },

  {
    'nvim-telescope/telescope.nvim',
    config = plugin('telescope'),
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
  }
})
