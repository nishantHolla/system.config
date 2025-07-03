local stats_component = {}

stats_component.make_stat = function(options)
  local stat = {}

  stat.icon = AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_icon(options.default_icon),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })

  stat.value = AwesomeWM.wibox.widget({
    text = "",
    valign = "center",
    font = AwesomeWM.theme.default_font .. " 16",
    widget = AwesomeWM.wibox.widget.textbox
  })

  local shape = function(c, w, h)
    AwesomeWM.gears.shape.rounded_rect(c, w, h, 100)
  end

  stat.bar = AwesomeWM.wibox.widget({
    value = 0,
    max_value = options.max_value,
    shape = shape,
    bar_shape = shape,
    color = options.color,
    background_color = AwesomeWM.theme.white,
    paddings = 6,
    widget = AwesomeWM.wibox.widget.progressbar
  })

  stat.main = AwesomeWM.wibox.widget({
    stat.icon,
    stat.value,
    stat.bar,
    forced_height = 50,
    layout = AwesomeWM.wibox.layout.ratio.horizontal
  })

  stat.main:ajust_ratio(2, 0.2, 0.2, 0.6)

  stat.refresh = function()
    options.refresh(function(icon, value)
      stat.icon.image = icon
      stat.value.text = tostring(value) .. "%"
      stat.bar.value = value
    end)
  end

  return stat
end

stats_component.volume_stat = stats_component.make_stat({
  default_icon = "volumeLow",
  max_value = 100,
  color = AwesomeWM.theme.red,
  refresh = AwesomeWM.functions.volume.find_volume_and
})

stats_component.brightness_stat = stats_component.make_stat({
  default_icon = "brightnessLow",
  max_value = 255,
  color = AwesomeWM.theme.blue,
  refresh = AwesomeWM.functions.brightness.find_brightness_and
})

stats_component.battery_stat = stats_component.make_stat({
  default_icon = "batteryLow",
  max_value = 100,
  color = AwesomeWM.theme.green,
  refresh = AwesomeWM.functions.battery.find_battery_and
})

stats_component.storage_stat = stats_component.make_stat({
  default_icon = "hardDrive",
  max_value = 100,
  color = AwesomeWM.theme.yellow,
  refresh = AwesomeWM.functions.storage.find_storage_and
})

stats_component.main = AwesomeWM.wibox.widget({
  {
    stats_component.volume_stat.main,
    stats_component.brightness_stat.main,
    stats_component.battery_stat.main,
    stats_component.storage_stat.main,
    spacing = 50,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  },
  top = 20,
  left = 20,
  right = 20,
  widget = AwesomeWM.wibox.container.margin
})

stats_component.refresh = function()
  stats_component.volume_stat.refresh()
  stats_component.brightness_stat.refresh()
  stats_component.battery_stat.refresh()
  stats_component.storage_stat.refresh()
end

return stats_component
