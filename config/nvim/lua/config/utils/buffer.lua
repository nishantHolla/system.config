local M = {}

M.close_buffer = function()
  if vim.api.nvim_buf_get_name(0) == "" then
    vim.cmd("q")
  elseif vim.bo.filetype == "man" then
    vim.cmd("bd")
  else
    vim.cmd("Bdelete")
  end
end

return M
