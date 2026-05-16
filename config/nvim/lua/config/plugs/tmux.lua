local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt

key({"n", "t"}, "<c-h>", "<cmd>TmuxNavigateLeft<cr>", k_opt("Tmux move left"))
key({"n", "t"}, "<c-j>", "<cmd>TmuxNavigateDown<cr>", k_opt("Tmux move down"))
key({"n", "t"}, "<c-k>", "<cmd>TmuxNavigateUp<cr>", k_opt("Tmux move up"))
key({"n", "t"}, "<c-l>", "<cmd>TmuxNavigateRight<cr>", k_opt("Tmux move right"))
key("n", "<leader>th", ':execute "silent !tmux split-window -c" shellescape(expand("%:p:h"), 1)<cr>', k_opt("Tmux horizontal split"))
key("n", "<leader>tv", ':execute "silent !tmux split-window -h -c" shellescape(expand("%:p:h"), 1)<cr>', k_opt("Tmux vertical split"))
