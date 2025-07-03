local date_and_time_component = {}
local utils = require("widgets.dashboard.utils")

-- Date

date_and_time_component.offset = 0

date_and_time_component.calendar_prev = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_icon("arrowLeft"),
  resize = true,
  widget = AwesomeWM.wibox.widget.imagebox
})

date_and_time_component.calendar_text = AwesomeWM.wibox.widget({
  text = os.date("%B %Y"),
  font = AwesomeWM.theme.default_font .. ' 12',
  align = "center",
  widget = AwesomeWM.wibox.widget.textbox
})

date_and_time_component.calendar_next = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_icon("arrowRight"),
  resize = true,
  widget = AwesomeWM.wibox.widget.imagebox
})

date_and_time_component.calendar_control = AwesomeWM.wibox.widget({
  date_and_time_component.calendar_prev,
  date_and_time_component.calendar_text,
  date_and_time_component.calendar_next,
  forced_height = 40,
  layout = AwesomeWM.wibox.layout.align.horizontal
})

date_and_time_component.calendar = AwesomeWM.wibox.widget({
  date = os.date("*t"),
  font = AwesomeWM.theme.default_font .. " 20",
  spacing = 10,
  fn_embed = function(_widget, _flag, _date)
    local rect = _widget

    if _flag == "header" then
      return AwesomeWM.wibox.widget({})
    elseif _flag == "weekday" then
      rect = AwesomeWM.wibox.widget({
        _widget,
        fg = AwesomeWM.theme.blue,
        widget = AwesomeWM.wibox.container.background,
      })
    elseif _flag == "focus" and date_and_time_component.offset == 0 then
      rect = AwesomeWM.wibox.widget({
        _widget,
        fg = AwesomeWM.theme.red,
        widget = AwesomeWM.wibox.container.background,
      })
    end

    return rect
  end,
  widget = AwesomeWM.wibox.widget.calendar.month,
})

date_and_time_component.date = AwesomeWM.wibox.widget({
  date_and_time_component.calendar_control,
  date_and_time_component.calendar,
  layout = AwesomeWM.wibox.layout.fixed.vertical
})

utils.add_button_actions(date_and_time_component.calendar_text, function()
  date_and_time_component.offset = 0
  date_and_time_component.refresh()
end)

utils.add_button_actions(date_and_time_component.calendar_prev, function()
  date_and_time_component.offset = date_and_time_component.offset - 1
  date_and_time_component.refresh()
end)

utils.add_button_actions(date_and_time_component.calendar_next, function()
  date_and_time_component.offset = date_and_time_component.offset + 1
  date_and_time_component.refresh()
end)

-- Time

date_and_time_component.time_upper = AwesomeWM.wibox.widget({
  format = "%I:%M:%S %p",
  refresh = 1,
  font = AwesomeWM.theme.default_font .. " 32",
  align = "center",
  widget = AwesomeWM.wibox.widget.textclock
})

date_and_time_component.time_lower = AwesomeWM.wibox.widget({
  format = "%A %d %b %Y",
  refresh = 3600,
  font = AwesomeWM.theme.default_font .. " 12",
  align = "center",
  widget = AwesomeWM.wibox.widget.textclock
})

date_and_time_component.time = AwesomeWM.wibox.widget({
  date_and_time_component.time_upper,
  date_and_time_component.time_lower,
  spacing = 10,
  layout = AwesomeWM.wibox.layout.fixed.vertical
})

date_and_time_component.layout = AwesomeWM.wibox.widget({
  date_and_time_component.date,
  {
    date_and_time_component.time,
    valign = "center",
    widget = AwesomeWM.wibox.container.place
  },
  spacing = 40,
  layout = AwesomeWM.wibox.layout.ratio.horizontal
})

date_and_time_component.main = AwesomeWM.wibox.widget({
  date_and_time_component.layout,
  margins = 40,
  widget = AwesomeWM.wibox.container.margin
})

date_and_time_component.layout:ajust_ratio(2, 0.5, 0.5, 0)

date_and_time_component.refresh = function()
  local date = os.date("*t")
  date.month = date.month + date_and_time_component.offset

  while date.month > 12 do
    date.month = date.month - 12
    date.year = date.year + 1
  end

  while date.month < 1 do
    date.month = date.month + 12
    date.year = date.year - 1
  end

  local timestamp = os.time(date)
  local formatted_date = os.date("%B %Y", timestamp)

  date_and_time_component.calendar_text.text = formatted_date
  date_and_time_component.calendar.date = date
end

return date_and_time_component
