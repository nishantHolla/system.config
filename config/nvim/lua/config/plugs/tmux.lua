local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt

key("n", "<c-h>", ":TmuxNavigateLeft<cr>", k_opt("Tmux move left"))
key("n", "<c-j>", ":TmuxNavigateDown<cr>", k_opt("Tmux move down"))
key("n", "<c-k>", ":TmuxNavigateUp<cr>", k_opt("Tmux move up"))
key("n", "<c-l>", ":TmuxNavigateRight<cr>", k_opt("Tmux move right"))
key("n", "<leader>th", ':execute "silent !tmux split-window -c" shellescape(expand("%:p:h"), 1)<cr>', k_opt("Tmux horizontal split"))
key("n", "<leader>tv", ':execute "silent !tmux split-window -h -c" shellescape(expand("%:p:h"), 1)<cr>', k_opt("Tmux vertical split"))
