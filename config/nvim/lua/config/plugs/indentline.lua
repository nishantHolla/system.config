local highlight = {
  "IndentHighlight"
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IndentHighlight", { fg = "#555555" })
end)

require("ibl").setup({
  indent = { char = "¦", highlight = highlight },
  scope = { enabled = false }
})

local indent_blankline_augroup = vim.api.nvim_create_augroup("indent_blankline_augroup", {clear = true})
vim.api.nvim_create_autocmd("ModeChanged", {
  group = indent_blankline_augroup,
  pattern = "[vV\x16]*:*",
  command = "IBLEnable",
  desc = "Enable indent-blankline when exiting visual mode"
})

vim.api.nvim_create_autocmd("ModeChanged", {
  group = indent_blankline_augroup,
  pattern = "*:[vV\x16]*",
  command = "IBLDisable",
  desc = "Disable indent-blankline when exiting visual mode"
})
