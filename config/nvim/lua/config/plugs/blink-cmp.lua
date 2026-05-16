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
    },

    appearance = {
    },

    completion = {
        documentation = { auto_show = false },
        menu = { draw = { components = { kind_icon = { text = function() return "" end, }, }, }, },
        list = { selection = { preselect = false } }
    },

    sources = {
        default = { 'path', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
})
