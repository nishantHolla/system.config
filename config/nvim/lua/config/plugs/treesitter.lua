require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'astro',
    'bash',
    'c',
    'cpp',
    'css',
    'go',
    'html',
    'javascript',
    'lua',
    'nix',
    'python',
    'tsx',
    'typescript',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
})
