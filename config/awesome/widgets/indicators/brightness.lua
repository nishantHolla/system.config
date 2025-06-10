local brightness_indicator_sm = {}
local base = require("widgets.indicators.base")
local max_value = 255

brightness_indicator_sm.icon = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_brightness_icon(max_value),
  resize = true,
  widget = AwesomeWM.wibox.widget.imagebox
})

brightness_indicator_sm.slider = AwesomeWM.wibox.widget({
  max_value = max_value,
  value = 45,
  background_color = base.slider_outer_color,
  color = AwesomeWM.theme.blue,
  shape = base.shape,
  margins = base.inner_margins,
  paddings = base.padding,
  bar_shape = base.shape,
  widget = AwesomeWM.wibox.widget.progressbar
})

brightness_indicator_sm.value = AwesomeWM.wibox.widget({
  text = "0",
  font = AwesomeWM.theme.font,
  align = "center",
  valign = "center",
  widget = AwesomeWM.wibox.widget.textbox
})

brightness_indicator_sm.main = AwesomeWM.wibox.widget({
  {
    brightness_indicator_sm.icon,
    margins = base.inner_margins,
    widget = AwesomeWM.wibox.container.margin
  },
  {
    brightness_indicator_sm.slider,
    direction = "east",
    widget = AwesomeWM.wibox.container.rotate
  },
  {
    brightness_indicator_sm.value,
    margins = base.inner_margins,
    widget = AwesomeWM.wibox.container.margin
  },
  layout = AwesomeWM.wibox.layout.align.vertical
})

brightness_indicator_sm.wibox = AwesomeWM.wibox({
  widget = brightness_indicator_sm.main,
  visible = false,
  opacity = base.opacity,
  ontop = true,
  type = "dock",
  bg = base.background,
  height = base.height,
  width = base.width,
  shape = AwesomeWM.gears.shape.rounded_rect
})

brightness_indicator_sm.init = function()
  AwesomeWM.awful.placement.left(brightness_indicator_sm.wibox, { margins = base.margins })
end

brightness_indicator_sm.timer = AwesomeWM.gears.timer({
  timeout = base.timeout,
  callback = function()
    brightness_indicator_sm.wibox.visible = false
  end
})

brightness_indicator_sm.show = function()
  AwesomeWM.functions.brightness.find_brightness_and(function(icon, value)
    brightness_indicator_sm.icon.image = icon
    brightness_indicator_sm.slider.value = value
    brightness_indicator_sm.value.text = tostring(value)
    brightness_indicator_sm.wibox.visible = true
    brightness_indicator_sm.timer:again()
  end)
end

return brightness_indicator_sm
