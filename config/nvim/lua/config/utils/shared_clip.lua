local M = {}
local file = vim.fn.stdpath("cache") .. "/nvim_shared_clipboard"

M.copy =  function()
  local text = vim.fn.getreg('"')
  local f = io.open(file, "w")
  if f then
    f:write(text)
    f:close()
  end
end

M.paste = function()
  local f = io.open(file, "r")
  if f then
    local text = f:read("*a")
    f:close()
    vim.fn.setreg('"', text)
    vim.api.nvim_put({ text }, "c", true, true)
  end
end

return M

