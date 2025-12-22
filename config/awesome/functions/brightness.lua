local brightness_sm = {}

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    -- TODO: Update brightness indicators add required places
  end)
end

brightness_sm.increase = function()
  run("brightness set 5%+")
end

brightness_sm.decrease = function()
  run("brightness set 5%-")
end

brightness_sm.set = function(value)
  run("brightness set " .. tostring(value))
end

brightness_sm.find_brightness_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async("brightness get", function(stdout, stderr, error_reason, exit_code)
    local brightness = tonumber(stdout)
    local icon = AwesomeWM.assets.get_brightness_icon(brightness)

    callback(icon, brightness)
  end)
end

return brightness_sm
