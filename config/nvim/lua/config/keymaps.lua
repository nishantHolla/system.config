local sc = require('config.utils.shared_clip')
local b = require('config.utils.buffer')

Key = vim.keymap.set
K_Opt = function(desc, silent, noremap, buffer)
  if silent == nil then silent = true end
  if noremap == nil then noremap = true end
  if buffer then
    return { silent = silent, noremap = noremap, desc = desc, buffer = buffer }
  else
    return { silent = silent, noremap = noremap, desc = desc }
  end
end

vim.g.mapleader = ","

-- Text Movement
Key("i", "<a-h>", "<left>", K_Opt("Move left"))
Key("i", "<a-j>", "<down>", K_Opt("Move down"))
Key("i", "<a-k>", "<up>", K_Opt("Move up"))
Key("i", "<a-l>", "<right>", K_Opt("Move right"))
Key("i", "<leader><leader>", "<esc>", K_Opt("Go to normal mode"))

-- Local Clipboard
Key({"n", "v"}, "d", '"_d', K_Opt("Delete without changing clipboard"))
Key({"n", "v"}, "c", '"_c', K_Opt("Change without changing clipboard"))
Key({"n", "v"}, "x", '"_x', K_Opt("Delete character without changing clipboard"))

Key({"n", "v"}, "<leader>d", 'd', K_Opt("Delete with changing clipboard"))
Key({"n", "v"}, "<leader>c", 'c', K_Opt("Change with changing clipboard"))
Key({"n", "v"}, "<leader>x", 'x', K_Opt("Delete character with changing clipboard"))

-- File
Key("n", "<leader>ss", ":w<cr>", K_Opt("Write current buffer"))
Key("n", "<leader>sa", ":w<cr>", K_Opt("Write all buffers"))
Key("n", "<leader>qq", function() b.close_buffer() end, K_Opt("Close current buffer"))
Key("n", "<leader>qa", ":qa<cr>", K_Opt("Close all buffers"))

-- Buffer
Key("n", "<a-i>", ":bp<cr>", K_Opt("Go to previous buffer"))
Key("n", "<a-o>", ":bn<cr>", K_Opt("Go to next buffer"))

Key("n", "<esc>", ":nohl<cr>", K_Opt("Clear highlights"))

-- Numbers
Key({"n", "v", "o"}, "<a-a>", "1", K_Opt("Press 1"))
Key({"n", "v", "o"}, "<a-s>", "2", K_Opt("Press 2"))
Key({"n", "v", "o"}, "<a-d>", "3", K_Opt("Press 3"))
Key({"n", "v", "o"}, "<a-f>", "4", K_Opt("Press 4"))
Key({"n", "v", "o"}, "<a-g>", "5", K_Opt("Press 5"))
Key({"n", "v", "o"}, "<a-h>", "6", K_Opt("Press 6"))
Key({"n", "v", "o"}, "<a-j>", "7", K_Opt("Press 7"))
Key({"n", "v", "o"}, "<a-k>", "8", K_Opt("Press 8"))
Key({"n", "v", "o"}, "<a-l>", "9", K_Opt("Press 9"))
Key({"n", "v", "o"}, "<a-;>", "0", K_Opt("Press 0"))

-- Shared Clipboard
Key("n", "<leader>sc", function() sc.copy() end, K_Opt("Send text to shared clipboard"))
Key("n", "<leader>sp", function() sc.paste() end, K_Opt("Paste text from shared clipboard"))

-- Terminal
Key("t", "<esc>", "<c-\\><C-n>", K_Opt("Move from terminal mode to normal mode"))
