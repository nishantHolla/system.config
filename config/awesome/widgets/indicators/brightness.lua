local brightness_indicator_sm = {}
local v = require("widgets.values")

brightness_indicator_sm.icon = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_brightness_icon(0),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

brightness_indicator_sm.slider = function()
  return AwesomeWM.wibox.widget({
    minimum = 0,
    maximum = 100,
    value = 0,
    background_color = v.indicator_slider_outer_color,
    color = AwesomeWM.theme.blue,
    shape = v.indicator_shape,
    margins = v.indicator_margins,
    paddings = v.indicator_padding,
    bar_shape = v.indicator_shape,
    widget = AwesomeWM.wibox.widget.progressbar
  })
end

brightness_indicator_sm.value = function()
  return AwesomeWM.wibox.widget({
    text = "0",
    font = AwesomeWM.theme.font,
    align = "center",
    valign = "center",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

brightness_indicator_sm.instances = {}

brightness_indicator_sm.main = function(index)
  return AwesomeWM.wibox.widget({
    {
      brightness_indicator_sm.instances[index].icon,
      margins = v.indicator_margins,
      widget = AwesomeWM.wibox.container.margin
    },
    {
      {
        brightness_indicator_sm.instances[index].slider,
        direction = "east",
        widget = AwesomeWM.wibox.container.rotate
      },
      margins = v.indicator_margins,
      widget = AwesomeWM.wibox.container.margin
    },
    {
      brightness_indicator_sm.instances[index].value,
      margins = v.indicator_margins,
      widget = AwesomeWM.wibox.container.margin
    },
    layout = AwesomeWM.wibox.layout.align.vertical
  })
end

brightness_indicator_sm.make_wibox = function(index)
  if brightness_indicator_sm.instances[index] ~= nil then
    return
  end

  brightness_indicator_sm.instances[index] = {
    icon = brightness_indicator_sm.icon(),
    slider = brightness_indicator_sm.slider(),
    value = brightness_indicator_sm.value()
  }

  brightness_indicator_sm.instances[index].main = brightness_indicator_sm.main(index)

  brightness_indicator_sm.instances[index].wibox = AwesomeWM.wibox({
    widget = brightness_indicator_sm.instances[index].main,
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

brightness_indicator_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  brightness_indicator_sm.make_wibox(index)
  AwesomeWM.awful.placement.left(brightness_indicator_sm.instances[index].wibox, { margins = v.indicator_margins })

  brightness_indicator_sm.instances[index].timer = AwesomeWM.gears.timer({
    timeout = v.indicator_timeout,
    callback = function()
      brightness_indicator_sm.instances[index].wibox.visible = false
    end
  })

  AwesomeWM.functions.brightness.find_max_brightness_and(function(max_value)
    brightness_indicator_sm.instances[index].slider.maximum = max_value
  end)
end

brightness_indicator_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if brightness_indicator_sm.instances[index] == nil then
    return
  end

  AwesomeWM.functions.brightness.find_brightness_and(function(icon, value)
    local percentage = value / brightness_indicator_sm.instances[index].slider.maximum * 100
    brightness_indicator_sm.instances[index].wibox.visible = true
    brightness_indicator_sm.instances[index].icon.image = icon
    brightness_indicator_sm.instances[index].slider.value = value
    brightness_indicator_sm.instances[index].value.text = tostring(percentage) .. "%"
    brightness_indicator_sm.instances[index].timer:again()
  end, brightness_indicator_sm.instances[index].slider.maximum)
end

return brightness_indicator_sm
