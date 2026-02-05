local M = {}

-- Buffer

M.count_buffers = function()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      count = count + 1
    end
  end
  return count
end

M.close_buffer = function()
    local count = M.count_buffers()

    if vim.api.nvim_buf_get_name(0) == "" or count == 1 then
        vim.cmd("q")
    elseif vim.bo.filetype == "man" then
        vim.cmd("bd")
    else
        vim.cmd("Bdelete")
    end
end

-- Keymaps

M.key = vim.keymap.set

M.k_opt = function(desc, slient, noremap, buffer)
    if silent == nil then slient = true end
    if noremap == nil then noremap = true end
    if buffer then
        return { silent = silent, noremap = noremap, desc = des, buffer = buffer }
    else
        return { silent = silent, noremap = noremap, desc = desc }
    end
end

-- Clipboard

local shared_file = vim.fn.stdpath("cache") .. "/nvim_shared_clipboard"

M.shared_copy = function()
    local text = vim.fn.getreg('"')
    local f = io.open(shared_file, "w")
    if f then
        f:write(text)
        f:close()
    end
end

M.shared_paste = function()
    local f = io.open(shared_file, "r")
    if f then
        local text = {}
        for line in f:lines() do
            table.insert(text, line)
        end
        f:close()
        vim.api.nvim_put(text, "c", true, true)
    end
end

return M
