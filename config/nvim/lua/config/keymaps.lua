local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt

vim.g.mapleader = ","

-- Text movement
key("i", "<a-h>", "<left>", k_opt("Move left"))
key("i", "<a-j>", "<down>", k_opt("Move down"))
key("i", "<a-k>", "<up>", k_opt("Move up"))
key("i", "<a-l>", "<right>", k_opt("Move right"))
key("i", "<leader><leader>", "<esc>", k_opt("Move to normal mode"))

-- Local clipboard
key({"n", "v"}, "d", '"_d', k_opt("Delete text without changing the clipboard content"))
key({"n", "v"}, "c", '"_c', k_opt("Change text without changing the clipboard content"))
key({"n", "v"}, "x", '"_x', k_opt("Delete character without changing the clipboard content"))

key({"n", "v"}, "<leader>d", "d", k_opt("Delete text with changing the clipboard content"))
key({"n", "v"}, "<leader>c", "c", k_opt("Change text with changing the clipboard content"))
key({"n", "v"}, "<leader>x", "x", k_opt("Delete character with changing the clipboard content"))

key({"n", "v"}, "<leader>y", '"+y', k_opt("Copy to global clipboard"))
key("n", "<leader>p", '"+p', k_opt("Paste from global clipboard"))

-- Shared clipboard
key("n", "<leader>sc", function() utils.shared_copy() end, k_opt("Send text to shared clipboard"))
key("n", "<leader>sp", function() utils.shared_paste() end, k_opt("Paste text from shared clipboard"))

-- File
key("n", "<leader>ss", ":w<cr>", k_opt("Write current buffer"))
key("n", "<leader>sa", ":wa<cr>", k_opt("Write all buffers"))
key("n", "<leader>qq", function() utils.close_buffer() end, k_opt("Close current buffer"))
key("n", "<leader>qa", ":qa<cr>", k_opt("Close all buffers"))

-- Buffer
key("n", "<a-i>", ":bp<cr>", k_opt("Go to previous buffer"))
key("n", "<a-o>", ":bn<cr>", k_opt("Go to next buffer"))

key("n", "<esc>", ":nohl<cr>", k_opt("Clear highlights"))

-- Numbers
key({"n", "v", "o"}, "<a-a>", "1", k_opt("Press 1"))
key({"n", "v", "o"}, "<a-s>", "2", k_opt("Press 2"))
key({"n", "v", "o"}, "<a-d>", "3", k_opt("Press 3"))
key({"n", "v", "o"}, "<a-f>", "4", k_opt("Press 4"))
key({"n", "v", "o"}, "<a-g>", "5", k_opt("Press 5"))
key({"n", "v", "o"}, "<a-h>", "6", k_opt("Press 6"))
key({"n", "v", "o"}, "<a-j>", "7", k_opt("Press 7"))
key({"n", "v", "o"}, "<a-k>", "8", k_opt("Press 8"))
key({"n", "v", "o"}, "<a-l>", "9", k_opt("Press 9"))
key({"n", "v", "o"}, "<a-;>", "0", k_opt("Press 0"))

-- Terimnal
key("t", "<leader><leader>", "<c-\\><c-n>", k_opt("Move from terminal mode to normal mode"))

-- Tabs
key("n", "<leader>=", ":tabnew %<cr>", k_opt("Expand current buffer"))
key("n", "<leader>+", ":tabclose<cr>", k_opt("Close expanded tab"))
key("n", "<a-I>", ":tabprevious<cr>", k_opt("Go to previous tab"))
key("n", "<a-O>", ":tabnext<cr>", k_opt("Go to next tab"))
