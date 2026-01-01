local utils_sm = {}
local v = require("widgets.values")

utils_sm.margin_box = function(widget, margin)
  margin = margin or 2

  return AwesomeWM.wibox.widget({
    widget,
    margins = margin,
    widget = AwesomeWM.wibox.container.margin
  })
end

utils_sm.background_box = function(widget, bg, fg)
  bg = bg or AwesomeWM.theme.black
  fg = fg or AwesomeWM.theme.white

  return AwesomeWM.wibox.widget({
    widget,
    bg = bg,
    fg = fg,
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

  return AwesomeWM.wibox.widget({
    header,
    content,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })
end

utils_sm.make_box = function(text, widget)
  local inner = utils_sm.margin_box(utils_sm.inner_box(text, widget), v.dashboard_box_padding)
  local background = utils_sm.background_box(inner)
  return utils_sm.margin_box(background, v.dashboard_box_margin)
end

utils_sm.make_placeholder = function()
  return AwesomeWM.wibox.widget({
    text = "Placeholder",
    valign = "center",
    align = "center",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

return utils_sm
