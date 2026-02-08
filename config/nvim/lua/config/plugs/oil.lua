local utils = require("config.utils")
local key = utils.key
local k_opt = utils.k_opt

require("oil").setup({
    columns = {
        'permissions',
        'size',
        'mtime',
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    keymaps = {
        ['<a-l>'] = 'actions.select',
        ['<a-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<a-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<a-t>'] = { 'actions.select', opts = { tab = true } },
        ['<a-p>'] = 'actions.preview',
        ['<leader><leader>'] = { 'actions.close', mode = 'n' },
        ['<a-r>'] = 'actions.refresh',
        ['<a-k>'] = { 'actions.parent', mode = 'n' },
        ['<a-h>'] = { 'actions.open_cwd', mode = 'n' },
        ['<a-z>'] = { 'actions.toggle_hidden', mode = 'n' },
        ['<a-y>'] = { function() CopyOilPath(false) end, mode = 'n' },
        ['<a-Y>'] = { function() CopyOilPath(true) end, mode = 'n'},
    },
    use_default_keymaps = false,
})

key("n", "<leader><leader>", ":Oil<cr>", k_opt("Open oil"))
vim.cmd("highlight OilDir guibg=none guifg=#66d9ef")

function CopyOilPath(global)
    local oil = require("oil")
    local entry = oil.get_cursor_entry()
    local dir = oil.get_current_dir()
    local path = dir .. entry.name

    if global then
        vim.fn.setreg("+", path)
        vim.fn.setreg("*", path)
    else
        vim.fn.setreg('"', path)
    end

    vim.notify("Copied " .. path)
end
