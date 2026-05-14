local ts = require("nvim-treesitter")

local parsers = {
    'astro',
    'bash',
    'c',
    'cpp',
    'css',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'markdown_inline',
    'nix',
    'python',
    'rust',
    'tsx',
    'typescript',
}

ts.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        -- syntax highlighting, provided by Neovim
        local ok = pcall(vim.treesitter.start)
        if not ok then return end

        -- folds, provided by Neovim
        -- vim.opt.foldmethod = 'expr'
        -- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
