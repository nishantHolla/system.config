local brightness_sm = {}
local script = AwesomeWM.values.get_script("brightness")

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    if AwesomeWM.widgets.dashboard.is_visible() then
      AwesomeWM.widgets.dashboard.components.stats.refresh()
    else
      AwesomeWM.widgets.indicators.brightness.show()
    end
  end)
end

brightness_sm.increase = function()
  run(script .. " set 5%+")
end

brightness_sm.decrease = function()
  run(script .. " set 5%-")
end

brightness_sm.set = function(value)
  run(script .. " set " .. tostring(value))
end

brightness_sm.find_brightness_and = function(callback, max_value)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(script .. " get", function(stdout, stderr, error_reason, exit_code)
    local brightness = tonumber(stdout)
    local icon = AwesomeWM.assets.get_brightness_icon(brightness, max_value)

    callback(icon, brightness)
  end)
end

brightness_sm.find_max_brightness_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(script .. " max", function(stdout, stderr, error_reason, exit_code)
    local max_value = tonumber(stdout)
    callback(max_value)
  end)
end


return brightness_sm
