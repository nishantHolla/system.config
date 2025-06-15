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
        icon = "batteryChargin"
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

return battery_sm
