require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<a-j>'] = "move_selection_next",
        ['<a-k>'] = "move_selection_previous",
        ['<a-space>'] = "toggle_selection",
        ['<a-l>'] = "select_default",
        ['<a-t>'] = "select_tab",
        ['<a-v>'] = "select_vertical",
        ['<a-h>'] = "select_horizontal",
        ['<a-q>'] = "close",
        ['<escape>'] = "close",
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')

Key('n', '<leader>f', ':Telescope find_files theme=ivy<cr>', K_Opt('Open telescope find_files'))
Key('n', '<leader>F', ':Telescope git_files theme=ivy<cr>', K_Opt('Open telescope git_files'))

Key('n', '<leader>g', ':Telescope current_buffer_fuzzy_find theme=ivy<cr>', K_Opt('Open telescope current_buffer_fuzzy_find'))
Key('n', '<leader>G', ':Telescope live_grep theme=ivy<cr>', K_Opt('Open telescope live_grep'))

Key('n', '<leader><space>', ':Telescope buffers theme=ivy<cr>', K_Opt('Open telescope buffers'))

Key('n', '<leader>m', ':Telescope man_pages theme=ivy<cr>', K_Opt('Open telescope man_pages'))

Key('n', '<leader>v', ':Telescope treesitter theme=ivy<cr>', K_Opt('Open telescope treesitter'))
