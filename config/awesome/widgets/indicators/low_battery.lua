local low_battery_indicator_sm = {}

low_battery_indicator_sm.icon = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_icon("batteryLow"),
    resize = true,
    forced_height = 100,
    forced_width = 100,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

low_battery_indicator_sm.text = function()
  return AwesomeWM.wibox.widget({
    text = "Battery level low, connect me to a charger",
    align = "center",
    vlaign = "center",
    font = AwesomeWM.theme.default_font .. " 30",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

low_battery_indicator_sm.close_button = function()
  return AwesomeWM.wibox.widget({
    {
      {
        text = "close",
        font = AwesomeWM.theme.default_font .. " 20",
        valign = "center",
        align = "center",
        widget = AwesomeWM.wibox.widget.textbox
      },
      margins = 10,
      widget = AwesomeWM.wibox.container.margin
    },
    fd = AwesomeWM.theme.white,
    bg = AwesomeWM.theme.red,
    widget = AwesomeWM.wibox.container.background
  })
end

low_battery_indicator_sm.instances = {}

low_battery_indicator_sm.main = function(index)
  return AwesomeWM.wibox.widget({
    {
      low_battery_indicator_sm.instances[index].icon,
      align = "center",
      widget = AwesomeWM.wibox.container.place
    },
    {
      low_battery_indicator_sm.instances[index].text,
      fg = AwesomeWM.theme.white,
      widget = AwesomeWM.wibox.container.background
    },
    {
      low_battery_indicator_sm.instances[index].close_button,
      align = "center",
      widget = AwesomeWM.wibox.container.place
    },
    spacing = 50,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })
end

low_battery_indicator_sm.make_wibox = function(index)
  if low_battery_indicator_sm.instances[index] ~= nil then
    return
  end

  low_battery_indicator_sm.instances[index] = {
    icon = low_battery_indicator_sm.icon(),
    text = low_battery_indicator_sm.text(),
    close_button = low_battery_indicator_sm.close_button()
  }

  low_battery_indicator_sm.instances[index].main = low_battery_indicator_sm.main(index)
  low_battery_indicator_sm.instances[index].wibox = AwesomeWM.wibox({
    visible = false,
    opacity = 0.85,
    ontop = true,
    type = "dock",
    bg = AwesomeWM.theme.gray,
    input_passthrough = true,
    widget = AwesomeWM.wibox.widget({
      low_battery_indicator_sm.instances[index].main,
      widget = AwesomeWM.wibox.container.place
    })
  })

  low_battery_indicator_sm.instances[index].close_button:connect_signal("button::press", function()
    low_battery_indicator_sm.hide()
  end)
end

low_battery_indicator_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if low_battery_indicator_sm.instances[index] ~= nil then
    return
  end

  low_battery_indicator_sm.make_wibox(index)
  low_battery_indicator_sm.instances[index].wibox.width = screen.geometry.width
  low_battery_indicator_sm.instances[index].wibox.height = screen.geometry.height
  AwesomeWM.awful.placement.centered(low_battery_indicator_sm.instances[index].wibox, { margins = 10, parent = screen })
end

low_battery_indicator_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if low_battery_indicator_sm.instances[index] == nil then
    return
  end

  low_battery_indicator_sm.instances[index].wibox.visible = true
end

low_battery_indicator_sm.hide = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if low_battery_indicator_sm.instances[index] == nil then
    return
  end

  low_battery_indicator_sm.instances[index].wibox.visible = false
end

return low_battery_indicator_sm
