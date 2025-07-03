local utils_sm = {}

utils_sm.margin_box = function(widget, margin)
  margin = margin or 2

  return AwesomeWM.wibox.widget({
    widget,
    margins = margin,
    widget = AwesomeWM.wibox.container.margin
  })
end

utils_sm.background_box = function(widget)
  return AwesomeWM.wibox.widget({
    widget,
    bg = AwesomeWM.theme.black,
    widget = AwesomeWM.wibox.container.background
  })
end

utils_sm.inner_box = function(text, widget)
  if text == nil then
    return widget
  end

  local textbox = AwesomeWM.wibox.widget({
    text = text,
    font = AwesomeWM.theme.font,
    align = 'center',
    valign = 'center',
    widget = AwesomeWM.wibox.widget.textbox
  })

  local header = AwesomeWM.wibox.container.constraint(textbox, "exact", nil, 30)
  local content = AwesomeWM.wibox.container.constraint(widget, "max", nil, nil)

  local container = AwesomeWM.wibox.widget({
    header,
    content,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })

  return container
end


utils_sm.make_box = function(text, widget)
  local inner = utils_sm.margin_box(utils_sm.inner_box(text, widget), 10)
  local background = utils_sm.background_box(inner)
  return utils_sm.margin_box(background)
end

utils_sm.make_icon_button = function(icon_name, callback)
  local button = {}
  local b = AwesomeWM.beautiful

  button.background = AwesomeWM.wibox.widget({
    bg = b.dashboard_inactive_button_bg,
    fg = b.dashboard_inactive_button_fg,
    widget = AwesomeWM.wibox.container.background,
    shape = AwesomeWM.gears.shape.circle,
    shape_border_width = AwesomeWM.theme.dashboard_button_border_width,
    shape_border_color = AwesomeWM.theme.dashboard_inactive_button_border_bg
  })

  button.icon = AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_icon(icon_name),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })

  button.main = AwesomeWM.wibox.widget({
    {
      button.icon,
      margins = 10,
      widget = AwesomeWM.wibox.container.margin
    },
    widget = button.background
  })

  local enter_callback = function()
    button.background.bg = AwesomeWM.theme.dashboard_active_button_bg
    button.background.fg = AwesomeWM.theme.dashboard_active_button_fg
    button.background.shape_border_color = AwesomeWM.theme.dashboard_active_button_border_bg
  end

  local exit_callback = function()
    button.background.bg = AwesomeWM.theme.dashboard_inactive_button_bg
    button.background.fg = AwesomeWM.theme.dashboard_inactive_button_fg
    button.background.shape_border_color = AwesomeWM.theme.dashboard_inactive_button_border_bg
  end

  utils_sm.add_button_actions(button.main, callback, enter_callback, exit_callback)

  return button
end

utils_sm.add_button_actions = function(widget, callback, enter_callback, exit_callback)
  widget:connect_signal("mouse::enter", function()
    local c = AwesomeWM.mouse.current_wibox
    if c then
      c.cursor = "hand1"
    end
    AwesomeWM.functions.player.play_tick()
    if type(enter_callback) == "function" then
      enter_callback()
    end
  end)

  widget:connect_signal("mouse::leave", function()
    local c = AwesomeWM.mouse.current_wibox
    if c then
      c.cursor = "left_ptr"
    end
    if type(exit_callback) == "function" then
      exit_callback()
    end
  end)

  widget:connect_signal("button::press", callback)
end

return utils_sm

