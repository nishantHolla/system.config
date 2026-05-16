local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt

local term_buf = nil
local term_win = nil

function ToggleTerminal()
    -- If terminal window exists, hide it
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
        term_win = nil
        return
    end

    -- Create terminal buffer if needed
    if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
        vim.cmd("botright split")
        vim.cmd("terminal")

        term_buf = vim.api.nvim_get_current_buf()
        term_win = vim.api.nvim_get_current_win()
    else
        vim.cmd("botright split")
        term_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(term_win, term_buf)
    end

    vim.wo.winbar = nil
    vim.cmd("startinsert")
end

key({"n", "t"}, "..", ToggleTerminal, k_opt("Toggle terminal"))
