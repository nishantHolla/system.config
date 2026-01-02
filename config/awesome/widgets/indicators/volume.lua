local volume_indicator_sm = {}
local v = require("widgets.values")

volume_indicator_sm.icon = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_volume_icon(0),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

volume_indicator_sm.slider = function()
  return AwesomeWM.wibox.widget({
    minimum = 0,
    maximum = 100,
    value = 0,
    background_color = v.indicator_slider_outer_color,
    color = AwesomeWM.theme.red,
    shape = v.indicator_shape,
    margins = v.indicator_margins,
    paddings = v.indicator_padding,
    bar_shape = v.indicator_shape,
    widget = AwesomeWM.wibox.widget.progressbar
  })
end

volume_indicator_sm.value = function()
  return AwesomeWM.wibox.widget({
    text = "0",
    font = AwesomeWM.theme.font,
    align = "center",
    valign = "center",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

volume_indicator_sm.instances = {}

volume_indicator_sm.main = function(index)
  return AwesomeWM.wibox.widget({
    {
      volume_indicator_sm.instances[index].icon,
      margins = v.indicator_margins,
      widget = AwesomeWM.wibox.container.margin
    },
    {
      {
        volume_indicator_sm.instances[index].slider,
        direction = "east",
        widget = AwesomeWM.wibox.container.rotate
      },
      margins = v.indicator_margins,
      widget = AwesomeWM.wibox.container.margin
    },
    {
      volume_indicator_sm.instances[index].value,
      margins = v.indicator_margins,
      widget = AwesomeWM.wibox.container.margin
    },
    layout = AwesomeWM.wibox.layout.align.vertical
  })
end

volume_indicator_sm.make_wibox = function(index)
  if volume_indicator_sm.instances[index] ~= nil then
    return
  end

  volume_indicator_sm.instances[index] = {
    icon = volume_indicator_sm.icon(),
    slider = volume_indicator_sm.slider(),
    value = volume_indicator_sm.value()
  }

  volume_indicator_sm.instances[index].main = volume_indicator_sm.main(index)

  volume_indicator_sm.instances[index].wibox = AwesomeWM.wibox({
    widget = volume_indicator_sm.instances[index].main,
    visible = false,
    opacity = v.indicator_opacity,
    ontop = true,
    type = "dock",
    bg = v.indicator_bg,
    height = v.indicator_length,
    width = v.indicator_width,
    shape = AwesomeWM.gears.shape.rounded_rect
  })
end

volume_indicator_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  volume_indicator_sm.make_wibox(index)
  AwesomeWM.awful.placement.right(volume_indicator_sm.instances[index].wibox, { margins = v.indicator_margins, parent = screen })

  volume_indicator_sm.instances[index].timer = AwesomeWM.gears.timer({
    timeout = v.indicator_timeout,
    callback = function()
      volume_indicator_sm.instances[index].wibox.visible = false
    end
  })
end

volume_indicator_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if volume_indicator_sm.instances[index] == nil then
    return
  end

  AwesomeWM.functions.volume.find_volume_and(function(icon, value)
    local ratio = value / volume_indicator_sm.instances[index].slider.maximum
    volume_indicator_sm.instances[index].wibox.visible = true
    volume_indicator_sm.instances[index].icon.image = icon
    volume_indicator_sm.instances[index].slider:set_value(ratio)
    volume_indicator_sm.instances[index].value.text = tostring(math.floor(ratio * 100)) .. "%"
    volume_indicator_sm.instances[index].timer:again()
  end)
end

return volume_indicator_sm
