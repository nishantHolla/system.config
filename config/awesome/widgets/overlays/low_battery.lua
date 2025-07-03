local low_battery_sm = {}

low_battery_sm.background_color = "#000000"
low_battery_sm.opacity = 0.8
low_battery_sm.height = 15
low_battery_sm.width = 100

low_battery_sm.main = AwesomeWM.wibox.widget({
  text = "Low Battery",
  font = AwesomeWM.theme.default_font .. " 10",
  widget = AwesomeWM.wibox.widget.textbox
})

low_battery_sm.wibox = AwesomeWM.wibox({
  widget = low_battery_sm.main,
  visible = false,
  opacity = low_battery_sm.opacity,
  ontop = true,
  type = "desktop",
  bg = low_battery_sm.background_color,
  height = low_battery_sm.height,
  width = low_battery_sm.width
})

low_battery_sm.init = function()
  low_battery_sm.wibox.x = 200
  low_battery_sm.wibox.y = 0
end

low_battery_sm.show = function()
  low_battery_sm.wibox.visible = true
end

low_battery_sm.hide = function()
  low_battery_sm.wibox.visible = false
end

low_battery_sm.toggle = function()
  low_battery_sm.wibox.visible = not low_battery_sm.wibox.visible
end

return low_battery_sm
