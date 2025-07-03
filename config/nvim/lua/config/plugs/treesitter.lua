require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'html',
    'css',
    'javascript',
    'typescript',
    'tsx',
    'astro',
    'c',
    'cpp',
    'python',
    'nix'
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
})
