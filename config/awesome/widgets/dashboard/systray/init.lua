local systray_component = {}

systray_component.instances = {}

systray_component.main = function(index)
  return AwesomeWM.wibox.widget.systray()
end

systray_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if systray_component.instances[index] ~= nil then
    return systray_component.instances[index].main
  end

  systray_component.instances[index] = {
    main = systray_component.main(index)
  }

  return systray_component.instances[index].main
end

return systray_component
