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
        'rust',
        'tsx',
        'typescript',
        'markdown',
        'markdown_inline'
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
})
