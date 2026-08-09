require("blink.cmp").setup({
    keymap = {
        preset = "none",

        ['<a-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<a-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<a-d>'] = { 'show_documentation', 'fallback' },
        ['<a-Space>'] = { 'accept', 'show' },
        ['<a-e>'] = { 'cancel', 'fallback' },
        ['<a-h>'] = { 'accept', 'fallback' },
        ['<a-k>'] = { 'select_prev', 'fallback' },
        ['<a-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    completion = {
        documentation = { auto_show = false },
        menu = { draw = { components = { kind_icon = { text = function() return "" end, }, }, }, },
        list = { selection = { preselect = false } }
    },

    sources = {
        default = function(ctx)
            local success, node = pcall(vim.treesitter.get_node)
            if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                return { 'buffer' }
            else
                return { 'lsp', 'path', 'buffer' }
            end
        end,

        providers = {
            buffer = {
                opts = {
                    get_bufnrs = function()
                        return vim.tbl_filter(function(bufnr)
                            return vim.bo[bufnr].buftype == ''
                        end, vim.api.nvim_list_bufs())
                    end
                }
            }
        }
    },

    signature = {
        enabled = true,
        trigger = { enabled = false }
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
})
