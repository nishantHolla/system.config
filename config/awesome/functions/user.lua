local user_sm = {}
local script = AwesomeWM.values.get_script("user-stats")

user_sm.find_uptime_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(script .. " uptime", function(stdout, stderr, error_reason, exit_code)
    callback(stdout)
  end)
end

user_sm.find_process_count_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(script .. " process_count", function(stdout, stderr, error_reason, exit_code)
    local value = tonumber(stdout)
    callback(value)
  end)
end

return user_sm
