CloseBuffer = function()
  local ls = vim.api.nvim_command_output("ls")
  local count  = select(2, ls:gsub('\n', '\n'))
  if count == 0 then
    vim.cmd("q")
  else
    vim.cmd("Bdelete")
  end
end
