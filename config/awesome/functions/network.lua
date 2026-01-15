local network_sm = {}

network_sm.switch_on_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async("nmcli networking on", function(stdio, stderr, exit_reason, exit_code)
    callback()
  end)
end

network_sm.switch_off_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async("nmcli networking off", function(stdio, stderr, exit_reason, exit_code)
    callback()
  end)
end

network_sm.refresh = function()
  network_sm.switch_off_and(function()
    network_sm.switch_on_and(function() end)
  end)
end

return network_sm
