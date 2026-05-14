require('mini.icons').setup()
local dashboard = require("alpha.themes.dashboard")

-- Header (ASCII art)
dashboard.section.header.val = {
    " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}

-- Buttons
dashboard.section.buttons.val = {
    dashboard.button("e", " New file", ":ene <BAR> <CR>"),
    dashboard.button("c", " Config", ":e $MYVIMRC<CR>"),
    dashboard.button("q", "󰩈 Quit", ":qa<CR>"),
}

require("alpha").setup(dashboard.config)

-- Hide statusline when Alpha is active
vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        vim.opt.laststatus = 0
    end,
})

-- Restore statusline when leaving Alpha
vim.api.nvim_create_autocmd("BufUnload", {
    buffer = 0,
    callback = function()
        vim.opt.laststatus = 3  -- or 2 depending on your setup
    end,
})
