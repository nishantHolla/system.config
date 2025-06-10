local brightness_sm = {}

brightness_sm.script = AwesomeWM.values.get_script("brightness")

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    -- TODO: Update page stats
    AwesomeWM.widgets.indicators.brightness.show()
  end)
end

brightness_sm.get = function()
  return (brightness_sm.script .. " get")
end

brightness_sm.increase = function()
  run(brightness_sm.script .. " set 5+")
end

brightness_sm.decrease = function()
  run(brightness_sm.script .. " set 5-")
end

brightness_sm.set = function(value)
  run(brightness_sm.script .. " set " .. tostring(value))
end

brightness_sm.find_brightness_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(brightness_sm.get(), function(stdout, stderr, error_reason, exit_code)
    local brightness = tonumber(stdout)
    local icon = AwesomeWM.assets.get_brightness_icon(brightness)

    callback(icon, brightness)
  end)
end

return brightness_sm
