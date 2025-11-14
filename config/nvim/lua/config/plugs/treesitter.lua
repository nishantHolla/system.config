require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'astro',
    'c',
    'cpp',
    'css',
    'go',
    'html',
    'javascript',
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
