local battery_service_sm = {}

battery_service_sm.low_battery_threshold = 15
battery_service_sm.not_warned = true

battery_service_sm.timer = AwesomeWM.gears.timer({
  timeout = 60,
  callback = function()
    AwesomeWM.functions.battery.find_battery_and(function(icon, value, is_charging)
      if
        not battery_service_sm.is_charging and
        value < battery_service_sm.low_battery_threshold and
        battery_service_sm.not_warned
      then
        AwesomeWM.widgets.indicators.low_battery.show()
        battery_service_sm.not_warned = false
      end

      if
        battery_service_sm.is_charging or
        value >= battery_service_sm.low_battery_threshold
      then
        battery_service_sm.not_warned = true
      end
    end)
    return true
  end
})

battery_service_sm.start = function()
  battery_service_sm.timer:start()
end

return battery_service_sm
