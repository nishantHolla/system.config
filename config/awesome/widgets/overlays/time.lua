local time_sm = {}
local v = require("widgets.values")

time_sm.background_color = v.overlays_bg
time_sm.opacity = v.overlays_opacity
time_sm.height = v.overlays_height
time_sm.width = 70
time_sm.font = v.overlays_font

time_sm.main = function()
  return AwesomeWM.wibox.widget({
    align = "center",
    valign = "center",
    format = "%I : %M %p",
    font = time_sm.font,
    widget = AwesomeWM.wibox.widget.textclock
  })
end

time_sm.instances = {}

time_sm.make_wibox = function(index)
  if time_sm.instances[index] ~= nil then
    return
  else
    time_sm.instances[index] = {}
  end

  time_sm.instances[index].main = time_sm.main()

  time_sm.instances[index].wibox = AwesomeWM.wibox({
    widget = time_sm.instances[index].main,
    visible = true,
    opacity = time_sm.opacity,
    ontop = true,
    type = "desktop",
    bg = time_sm.background_color,
    height = time_sm.height,
    width = time_sm.width
  })
end

time_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  time_sm.make_wibox(index)
  AwesomeWM.awful.placement.top(time_sm.instances[index].wibox, { margins = 0 })
end

time_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if time_sm.instances[index] == nil then
    return
  end

  time_sm.instances[index].wibox.visible = true
end

time_sm.hide = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if time_sm.instances[index] == nil then
    return
  end

  time_sm.instances[index].wibox.visible = false
end

time_sm.toggle = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if time_sm.instances[index] == nil then
    return
  end

  time_sm.instances[index].wibox.visible = not time_sm.instances[index].wibox.visible
end

return time_sm
