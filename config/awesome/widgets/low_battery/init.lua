local low_battery_sm = {}

low_battery_sm.icon = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_icon("batteryLow"),
  resize = true,
  forced_height = 100,
  forced_width = 100,
  widget = AwesomeWM.wibox.widget.imagebox
})

low_battery_sm.text = AwesomeWM.wibox.widget({
  text = "",
  font = AwesomeWM.theme.default_font .. " 30",
  widget = AwesomeWM.wibox.widget.textbox
})

low_battery_sm.close_button = AwesomeWM.wibox.widget({
  {
    {
      text = "Close",
      font = AwesomeWM.theme.default_font .. " 20",
      valign = "center",
      align = "center",
      widget = AwesomeWM.wibox.widget.textbox
    },
    margins = 10,
    widget = AwesomeWM.wibox.container.margin
  },
  fg = AwesomeWM.theme.white,
  bg = AwesomeWM.theme.red,
  widget = AwesomeWM.wibox.container.background
})

low_battery_sm.main = AwesomeWM.wibox.widget({
  {
    low_battery_sm.icon,
    align = "center",
    widget = AwesomeWM.wibox.container.place
  },
  {
    low_battery_sm.text,
    fg = AwesomeWM.theme.white,
    widget = AwesomeWM.wibox.container.background
  },
  {
    low_battery_sm.close_button,
    widget = AwesomeWM.wibox.container.place
  },
  spacing = 50,
  layout = AwesomeWM.wibox.layout.fixed.vertical
})

low_battery_sm.wibox = AwesomeWM.wibox({
  visible = false,
  opacity = 0.85,
  ontop = true,
  type = "dock",
  bg = AwesomeWM.theme.gray,
  input_passthrough = false,
  widget = AwesomeWM.wibox.widget({
    low_battery_sm.main,
    align = "center",
    valign = "center",
    widget = AwesomeWM.wibox.container.place
  })
})

low_battery_sm.close_button:connect_signal("button::press", function()
  low_battery_sm.hide()
end)

low_battery_sm.init = function()
  low_battery_sm.wibox.width = AwesomeWM.values.screen_width
  low_battery_sm.wibox.height = AwesomeWM.values.screen_height
  AwesomeWM.awful.placement.centered(low_battery_sm.wibox, { margins = 0 })
end

low_battery_sm.show = function()
  AwesomeWM.functions.battery.find_battery_and(function(icon, battery_value)
    low_battery_sm.text.text = "Battery level less than " .. tostring(battery_value) .. "%. Connect me to a charger!"
    AwesomeWM.functions.brightness.find_brightness_and(function(_, value)
      low_battery_sm.brightness_value = value
      if value > 15 then
        AwesomeWM.functions.brightness.set(15)
      end
      low_battery_sm.wibox.visible = true
    end)
  end
  )
end

low_battery_sm.hide = function()
  if low_battery_sm.brightness_value then
    AwesomeWM.functions.brightness.set(low_battery_sm.brightness_value)
  end
  low_battery_sm.wibox.visible = false
end

return low_battery_sm
