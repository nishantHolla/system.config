CloseBuffer = function()
  local ls = vim.api.nvim_command_output("ls")
  local count  = select(2, ls:gsub('\n', '\n'))
  if count == 0 then
    vim.cmd("q")
  else
    vim.cmd("Bdelete")
  end
end

GetCurrentText = function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  if start_pos[2] ~= 0 and end_pos[2] ~= 0 and
    (start_pos[2] ~= end_pos[2] or start_pos[3] ~= end_pos[3]) then
    local start_line, start_col = start_pos[2], start_pos[3]
    local end_line, end_col = end_pos[2], end_pos[3]

    local lines = vim.api.nvim_buf_get_text(0, start_line - 1, start_col - 1,
      end_line - 1, end_col, {})

    return table.concat(lines, '\n')
  else
    local line_num = vim.fn.line('.')
    return vim.fn.getline(line_num)
  end
end

WriteToSharedClipboard = function()
  local text = GetCurrentText()

  local file, err = io.open("/tmp/nvim_clipboard", "w")
  if not file then
    error("Could not open file: " .. err)
  end

  file:write(text)
  file:close()
end

ReadFromSharedClipboard = function()
  local file, err = io.open("/tmp/nvim_clipboard", "r")
  if not file then
    error("Could not open file: " .. err)
  end

  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()

  vim.api.nvim_put(lines, 'c', true, true)
end
