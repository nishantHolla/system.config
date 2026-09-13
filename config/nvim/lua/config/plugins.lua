-- Lazy plugins manager
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

-- Plugins
require("lazy").setup({
    {
        "stevearc/oil.nvim",
        config = plugin("oil"),
        event = "VeryLazy",
    },

    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = plugin("treesitter"),
    },

    {
        "christoomey/vim-tmux-navigator",
        config = plugin("tmux"),
        event = "VeryLazy",
    },

    {
        "hrsh7th/nvim-cmp",
        config = plugin("nvim-cmp"),
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp-document-symbol"
        },
        event = "VeryLazy"
    },

    {
        "neovim/nvim-lspconfig",
        config = plugin("lsp"),
    },

    {
        "famiu/bufdelete.nvim",
        event = "VeryLazy",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = plugin("indent-blankline")
    },

    -- {
    --     "3rd/image.nvim",
    --     config = plugin("image")
    -- },

    {
        "nvim-telescope/telescope.nvim",
        config = plugin("telescope"),
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
    },

    {
        "tpope/vim-sleuth",
    },

    {
        "bluz71/vim-moonfly-colors",
        config = plugin("moonfly")
    }

})
