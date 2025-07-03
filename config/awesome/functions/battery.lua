local battery_sm = {}

battery_sm.find_battery_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(
    AwesomeWM.values.get_script("battery") .. " both",
    function(stdout, std_error, error_reason, error_code)
      local chargingIndicator = stdout:sub(-2)
      local text = stdout:sub(1, -3)
      local value = tonumber(text)
      local icon = ""

      if chargingIndicator == "C\n" then
        icon = "batteryCharging"
      elseif value > 95 then
        icon = "batteryFull"
      elseif value > 70 then
        icon = "batteryHigh"
      elseif value > 30 then
        icon = "batteryMedium"
      else
        icon = "batteryLow"
      end

      icon = AwesomeWM.assets.get_icon(icon)
      callback(icon, value)
    end
  )
end

battery_sm.find_uptime_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(
    AwesomeWM.values.get_script("uptime"),
    function(stdout, std_error, error_reason, error_code)
      callback(stdout)
    end
  )
end

battery_sm.check_battery = function()
  battery_sm.find_battery_and(function(_, value)
    if value <= AwesomeWM.values.low_battery_threshold then
      AwesomeWM.widgets.overlays.low_battery.show()
      if AwesomeWM.values.low_battery_warned == false then
        AwesomeWM.widgets.low_battery.show()
        AwesomeWM.values.low_battery_warned = true
      end
    elseif value > AwesomeWM.values.low_battery_threshold then
      AwesomeWM.widgets.overlays.low_battery.hide()
      AwesomeWM.values.low_battery_warned = false
    end
    battery_sm.timer:again()
  end)

end

battery_sm.timer = AwesomeWM.gears.timer({
  timeout = 10,
  callback = battery_sm.check_battery
})

return battery_sm
