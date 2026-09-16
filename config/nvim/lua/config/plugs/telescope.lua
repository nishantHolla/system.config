local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<A-j>"] = "move_selection_next",
				["<A-k>"] = "move_selection_previous",
				["<A-h>"] = "close",
				["<A-l>"] = "select_default",
				["<A-v>"] = "select_vertical",
				["<A-o>"] = "select_horizontal",
				["<A-t>"] = "select_tab",
				["<A-space>"] = "toggle_selection",
				["<A-s>"] = "preview_scrolling_down",
				["<A-d>"] = "preview_scrolling_up",
				["<A-a>"] = "preview_scrolling_left",
				["<A-f>"] = "preview_scrolling_right"
			}
		}
	}
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
