local date_time_component = {}
local utils = require("widgets.dashboard.utils")

date_time_component.instances = {}
date_time_component.offset = 0

-- Date

date_time_component.calendar_prev = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_icon("arrowLeft"),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

date_time_component.calendar_text = function()
  return AwesomeWM.wibox.widget({
    text = os.date("%B %Y"),
    font = AwesomeWM.theme.default_font .. " 12",
    align = "center",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

date_time_component.calendar_next = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_icon("arrowRight"),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

date_time_component.calendar_control = function(index)
  return AwesomeWM.wibox.widget({
    date_time_component.instances[index].calendar_prev,
    date_time_component.instances[index].calendar_text,
    date_time_component.instances[index].calendar_next,
    forced_height = 40,
    layout = AwesomeWM.wibox.layout.align.horizontal
  })
end

date_time_component.calendar = function()
  return AwesomeWM.wibox.widget({
    date = os.date("*t"),
    font = AwesomeWM.theme.default_font .. " 18",
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
      elseif _flag == "focus" and date_time_component.offset == 0 then
        rect = AwesomeWM.wibox.widget({
          _widget,
          fg = AwesomeWM.theme.red,
          widget = AwesomeWM.wibox.container.background,
        })
      end

      return rect
    end,
    widget = AwesomeWM.wibox.widget.calendar.month
  })
end

date_time_component.date = function(index)
  return AwesomeWM.wibox.widget({
    date_time_component.instances[index].calendar_control,
    date_time_component.instances[index].calendar,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })
end

date_time_component.time_upper = function()
  return AwesomeWM.wibox.widget({
    format = "%I:%M:%S %p",
    refresh = 1,
    font = AwesomeWM.theme.default_font .. " 32",
    align = "center",
    widget = AwesomeWM.wibox.widget.textclock
  })
end

date_time_component.time_lower = function()
  return AwesomeWM.wibox.widget({
    format = "%A %d %b %Y",
    refresh = 3600,
    font = AwesomeWM.theme.default_font .. " 12",
    align = "center",
    widget = AwesomeWM.wibox.widget.textclock
  })
end

date_time_component.time = function(index)
  return AwesomeWM.wibox.widget({
    date_time_component.instances[index].time_upper,
    date_time_component.instances[index].time_lower,
    spacing = 10,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })
end

date_time_component.main = function(index)
  local main = AwesomeWM.wibox.widget({
    date_time_component.instances[index].date,
    {
      date_time_component.instances[index].time,
      valign = "center",
      widget = AwesomeWM.wibox.container.place
    },
    spacing = 40,
    layout = AwesomeWM.wibox.layout.ratio.horizontal
  })

  main:ajust_ratio(2, 0.5, 0.5, 0)

  return utils.margin_box(main, 40)
end

date_time_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if date_time_component.instances[index] ~= nil then
    return date_time_component.instances[index].main
  end

  date_time_component.instances[index] = {
    calendar_prev = date_time_component.calendar_prev(),
    calendar_text = date_time_component.calendar_text(),
    calendar_next = date_time_component.calendar_next(),
    calendar = date_time_component.calendar(),
    time_upper = date_time_component.time_upper(),
    time_lower = date_time_component.time_lower()
  }

  date_time_component.instances[index].calendar_control = date_time_component.calendar_control(index)
  date_time_component.instances[index].date = date_time_component.date(index)
  date_time_component.instances[index].time = date_time_component.time(index)
  date_time_component.instances[index].main = date_time_component.main(index)

  utils.add_button_actions(date_time_component.instances[index].calendar_prev, function()
    date_time_component.offset = date_time_component.offset - 1
    date_time_component.refresh(screen)
  end)

  utils.add_button_actions(date_time_component.instances[index].calendar_next, function()
    date_time_component.offset = date_time_component.offset + 1
    date_time_component.refresh(screen)
  end)

  utils.add_button_actions(date_time_component.instances[index].calendar_text, function()
    date_time_component.offset = 0
    date_time_component.refresh(screen)
  end)

  return date_time_component.instances[index].main
end

date_time_component.refresh = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if date_time_component.instances[index] == nil then
    return
  end

  local date = os.date("*t")
  date.month = date.month + date_time_component.offset

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

  date_time_component.instances[index].calendar_text.text = formatted_date
  date_time_component.instances[index].calendar.date = date
end

return date_time_component
