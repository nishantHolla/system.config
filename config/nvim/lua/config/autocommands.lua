local usergroup = vim.api.nvim_create_augroup("UserGroup", { clear = true})
local autocommand = vim.api.nvim_create_autocmd

-- Set formatoptions
autocommand("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({'c', 'r', 'o'})
    end,
    group = usergroup,
})

-- Load view on open
autocommand("BufWinEnter", {
    pattern = "?*",
    command = "silent! loadview",
    group = usergroup,
})

-- Save view on close
autocommand("BufWinLeave", {
    pattern = "?*",
    command = "silent! mkview",
    group = usergroup,
})

-- Remove trailing whitespace on save
autocommand("BufWritePre", {
    pattern = '?*',
    command = [[let save_cursor = getpos(".") | %s/\s\+$//e | call setpos('.', save_cursor)]],
    group = usergroup,
})

-- Resize splits on window resize
autocommand("VimResized", {
    pattern = "*",
    command = "wincmd =",
    group = usergorup,
})

-- Indent option for Makefile
autocommand("Filetype", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 0
    end,
    group = usergroup,
})

-- Winbar with the file name
autocommand("BufWinEnter", {
    callback = function()
        local bt = vim.bo.buftype
        local ft = vim.bo.filetype

        local ignore = {
            "help",
            "nofile",
            "quickfix",
        }

        local ignore_ft = {
            "TelescopePrompt",
            "oil",
        }

        if vim.tbl_contains(ignore, bt) or vim.tbl_contains(ignore_ft, ft) then
            vim.wo.winbar = ""
        else
            local project_root = vim.fs.root(0, {".git"})
            if project_root == nil then
                vim.wo.winbar = "%F"
            else
                project_root = vim.fn.resolve(vim.fn.expand(project_root))
                local parent = vim.fn.fnamemodify(project_root, ":h")
                local path = vim.api.nvim_buf_get_name(0)

                if path:sub(1, #parent) == parent then
                    path = path:sub(#parent + 1)
                end
                vim.wo.winbar = "Git: " .. path
            end
        end
    end,
    group = usergroup,
})
