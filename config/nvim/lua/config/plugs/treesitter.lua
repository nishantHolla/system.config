require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'astro',
        'bash',
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'java',
        'javascript',
        'lua',
        'nix',
        'python',
        'tsx',
        'typescript',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
})
