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
	'llvm',
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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "llvm",
	callback = function()
		vim.bo.indentexpr = ""
		vim.bo.autoindent = true
		vim.bo.smartindent = true
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
		vim.bo.expandtab = true
	end,
})
