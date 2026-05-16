local image_formats = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }

require("image").setup({
    backend = "ueberzug",
    integrations = {
        markdown = {
            enable = false
        },
        html = {
            enable = false
        },
        css = {
            enable = false
        },
    },
    hijack_file_patterns = image_formats,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = image_formats,
    callback = function()
        local image = require("image")

        image.clear()

        image.from_file(vim.fn.expand("%"), {
            window = 0,
            x = 0,
            y = 0,
            width = vim.api.nvim_win_get_width(0),
        }):render()
    end,
})
