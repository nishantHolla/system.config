local stats_component = {}

stats_component.make_stat = function(options)
  local stat = {}

  stat.icon = AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_icon(options.default_icon),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })

  stat.value = AwesomeWM.wibox.widget({
    text = "Hello",
    valign = "center",
    font = AwesomeWM.theme.default_font .. " 16",
    widget = AwesomeWM.wibox.widget.textbox
  })

  local shape = function(c, w, h)
    return AwesomeWM.gears.shape.rounded_rect(c, w, h, 100)
  end

  stat.bar = AwesomeWM.wibox.widget({
    value = 0.5,
    minimum = 0,
    maximum = options.max_value,
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
      local ratio = value / stat.bar.maximum
      stat.icon.image = icon
      stat.value.text = tostring(math.floor(ratio * 100)) .. "%"
      stat.bar:set_value(ratio)
    end)
  end

  return stat
end

stats_component.volume_stat = function()
  return stats_component.make_stat({
    default_icon = "volumeLow",
    max_value = 100,
    color = AwesomeWM.theme.red,
    refresh = AwesomeWM.functions.volume.find_volume_and
  })
end

stats_component.brightness_stat = function()
  return stats_component.make_stat({
    default_icon = "brightnessLow",
    max_value = 255,
    color = AwesomeWM.theme.blue,
    refresh = AwesomeWM.functions.brightness.find_brightness_and
  })
end

stats_component.battery_stat = function()
  return stats_component.make_stat({
    default_icon = "batteryLow",
    max_value = 100,
    color = AwesomeWM.theme.green,
    refresh = AwesomeWM.functions.battery.find_battery_and
  })
end

stats_component.storage_stat = function()
  return stats_component.make_stat({
    default_icon = "hardDrive",
    max_value = 100,
    color = AwesomeWM.theme.yellow,
    refresh = AwesomeWM.functions.storage.find_storage_and
  })
end

stats_component.instances = {}

stats_component.main = function(index)
  return AwesomeWM.wibox.widget({
    {
      stats_component.instances[index].volume_stat.main,
      stats_component.instances[index].brightness_stat.main,
      stats_component.instances[index].battery_stat.main,
      stats_component.instances[index].storage_stat.main,
      spacing = 40,
      layout = AwesomeWM.wibox.layout.fixed.vertical
    },
    top = 20,
    left = 20,
    right = 20,
    widget = AwesomeWM.wibox.container.margin
  })
end

stats_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if stats_component.instances[index] ~= nil then
    return stats_component.instances[index].main
  end

  stats_component.instances[index] = {
    volume_stat = stats_component.volume_stat(),
    brightness_stat = stats_component.brightness_stat(),
    battery_stat = stats_component.battery_stat(),
    storage_stat = stats_component.storage_stat()
  }

  AwesomeWM.functions.brightness.find_max_brightness_and(function(max_value)
    stats_component.instances[index].brightness_stat.bar.maximum = max_value
  end)

  stats_component.instances[index].main = stats_component.main(index)
  return stats_component.instances[index].main
end

stats_component.refresh = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if stats_component.instances[index] == nil then
    return
  end

  stats_component.instances[index].volume_stat.refresh()
  stats_component.instances[index].brightness_stat.refresh()
  stats_component.instances[index].battery_stat.refresh()
  stats_component.instances[index].storage_stat.refresh()
end

return stats_component
