local time_sm = {}

time_sm.background_color = "#000000"
time_sm.opacity = 0.8
time_sm.height = 15
time_sm.width = 70

time_sm.main = AwesomeWM.wibox.widget({
  align = "center",
  valign = "center",
  format = "%I : %M %p",
  font = AwesomeWM.theme.default_font .. " 7",
  widget = AwesomeWM.wibox.widget.textclock
})

time_sm.wibox = AwesomeWM.wibox({
  widget = time_sm.main,
  visible = true,
  opacity = time_sm.opacity,
  ontop = true,
  type = "desktop",
  bg = time_sm.background_color,
  height = time_sm.height,
  width = time_sm.width
})

time_sm.init = function()
  AwesomeWM.awful.placement.top(time_sm.wibox, { margins = 0 })
end

time_sm.show = function()
  time_sm.wibox.visible = true
end

time_sm.hide = function()
  time_sm.wibox.visible = false
end

time_sm.toggle = function()
  time_sm.wibox.visible = not time_sm.wibox.visible
end

return time_sm
