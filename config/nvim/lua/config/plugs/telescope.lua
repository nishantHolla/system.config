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
		},
	},
	pickers = {
		man_pages = {
			sections = { "1", "2", "3" },
		},
	},
})

vim.keymap.set('n', '<leader>ff', "<cmd> Telescope find_files theme=ivy<cr>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', "<cmd> Telescope live_grep theme=ivy<cr>", { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', "<cmd> Telescope buffers theme=ivy<cr>", { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', "<cmd> Telescope help_tags theme=ivy<cr>", { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fm', "<cmd> Telescope man_pages theme=ivy<cr>", { desc = 'Manpages help' })
