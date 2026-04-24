local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt

vim.cmd("packadd nvim.undotree")

key("n", "<a-u>", ":Undotree<cr>", k_opt("Open undotree"))
