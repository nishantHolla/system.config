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
        'saghen/blink.cmp',
        version = '1.*',
        config = plugin("blink-cmp"),
        opts_extend = { "sources.default" }
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
        "loctvl842/monokai-pro.nvim",
        config = plugin("monokai_pro"),
    },

    {
        "goolord/alpha-nvim",
        config = plugin("alpha"),
        dependencies = {"nvim-mini/mini.icons"}
    },

    {
        "saghen/blink.indent",
        config = plugin("blink-indent")
    },

    {
        "tpope/vim-sleuth",
    },
})
