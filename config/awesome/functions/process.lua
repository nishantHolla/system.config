local process_sm = {}

process_sm.find_process_count_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async("ps -A", function(stdout, std_error, error_reason, error_code)
    local count  = select(2, stdout:gsub('\n', '\n'))
    local value = tonumber(count)
    callback(value)
  end)

end

return process_sm
