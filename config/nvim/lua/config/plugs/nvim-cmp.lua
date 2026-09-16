local cmp = require("cmp")

local lsp = { name = "nvim_lsp"}
local lsp_doc_symbol = { name = 'nvim_lsp_document_symbol' }
local luasnip = { name = "luasnip" }
local path = { name = "path" }
local signature = { name = 'nvim_lsp_signature_help' }
local buffer = {
	name = "buffer",
	option = {
		get_bufnrs = function()
			return vim.api.nvim_list_bufs()
		end
	}
}

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		['<a-b>'] = cmp.mapping.scroll_docs(-4),
		['<a-f>'] = cmp.mapping.scroll_docs(4),
		['<a-Space>'] = cmp.mapping.complete(),
		['<a-j>'] = cmp.mapping.select_next_item(),
		['<a-k>'] = cmp.mapping.select_prev_item(),
		['<a-e>'] = cmp.mapping.abort(),
		['<a-l>'] = cmp.mapping.confirm({ select = false }),
	}),

	sources = { signature, lsp, luasnip, buffer, path, }
})

cmp.setup.cmdline({'/', '?'}, {
	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-y>'] = cmp.mapping.confirm({ select = false }),
		['<C-e>'] = cmp.mapping.abort(),
	},
	sources = {
		lsp_doc_symbol,
		buffer,
	}
})
