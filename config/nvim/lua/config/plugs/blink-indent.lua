local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt
local indent = require('blink.indent')

indent.setup({
    static = {
        char = "|"
    },
    scope = {
        char = "|",
        highlights = {}
    }
})

key("n", "<leader>i", function() indent.enable(not indent.is_enabled()) end, k_opt("Toggle indent guides"))
vim.cmd("highlight BlinkIndent guifg=#3e4036")
