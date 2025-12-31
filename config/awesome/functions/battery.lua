local battery_sm = {}
local script = AwesomeWM.values.get_script("battery")

battery_sm.find_battery_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(script .. " both", function(stdout, std_error, error_reason, erro_code)
    local chargingIndicator = stdout:sub(-2)
    local text = stdout:sub(1, -3)
    local value = tonumber(text)
    local icon = AwesomeWM.assets.get_battery_icon(value, chargingIndicator)
    local is_charging = chargingIndicator == "C\n"

    callback(icon, value, is_charging)
  end)
end

return battery_sm
