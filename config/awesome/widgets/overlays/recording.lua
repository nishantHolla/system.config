local recording_sm = {}

recording_sm.color = "#ff0000"
recording_sm.size = 10
recording_sm.opacity = 0.3

recording_sm.main = function()
  return AwesomeWM.wibox.widget({
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })
end

recording_sm.instances = {}

recording_sm.make_wibox = function(index, screen)
  if recording_sm.instances[index] ~= nil then
    return
  else
    recording_sm.instances[index] = {}
  end

  local geo = screen.geometry

  recording_sm.instances[index].main = recording_sm.main()

  recording_sm.instances[index].wibox = AwesomeWM.wibox({
    widget = recording_sm.instances[index].main,
    visible = false,
    ontop = true,
    opacity = recording_sm.opacity,
    type = "desktop",
    bg = recording_sm.color,
    width = geo.width,
    height = recording_sm.size,
    input_passthrough = true
  })
end

recording_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  recording_sm.make_wibox(index, screen)
  AwesomeWM.awful.placement.bottom_left(recording_sm.instances[index].wibox, { margins = 0, parent = screen })
end

recording_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if recording_sm.instances[index] == nil then
    return
  end

  recording_sm.instances[index].wibox.visible = true
end

recording_sm.hide = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if recording_sm.instances[index] == nil then
    return
  end

  recording_sm.instances[index].wibox.visible = false
end

recording_sm.toggle = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if recording_sm.instances[index] == nil then
    return
  end

  recording_sm.instances[index].wibox.visible = not recording_sm.instances[index].wibox.visible
end

return recording_sm
