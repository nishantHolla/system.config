local volume_indicator_sm = {}
local base = require("widgets.indicators.base")
local max_value = 100

volume_indicator_sm.icon = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_volume_icon(max_value),
  resize = true,
  widget = AwesomeWM.wibox.widget.imagebox
})

volume_indicator_sm.slider = AwesomeWM.wibox.widget({
  max_value = max_value,
  value = 20,
  background_color = base.slider_outer_color,
  color = AwesomeWM.theme.red,
  shape = base.shape,
  margins = base.inner_margins,
  paddings = base.padding,
  bar_shape = base.shape,
  widget = AwesomeWM.wibox.widget.progressbar
})

volume_indicator_sm.value = AwesomeWM.wibox.widget({
  text = "0",
  font = AwesomeWM.theme.font,
  align = "center",
  valign = "center",
  widget = AwesomeWM.wibox.widget.textbox
})

volume_indicator_sm.main = AwesomeWM.wibox.widget({
  {
    volume_indicator_sm.icon,
    margins = base.inner_margins,
    widget = AwesomeWM.wibox.container.margin
  },
  {
    volume_indicator_sm.slider,
    direction = "east",
    widget = AwesomeWM.wibox.container.rotate
  },
  {
    volume_indicator_sm.value,
    margins = base.inner_margins,
    widget = AwesomeWM.wibox.container.margin
  },
  layout = AwesomeWM.wibox.layout.align.vertical
})

volume_indicator_sm.wibox = AwesomeWM.wibox({
  widget = volume_indicator_sm.main,
  visible = false,
  opacity = base.opacity,
  ontop = true,
  type = "dock",
  bg = base.background,
  height = base.height,
  width = base.width,
  shape = AwesomeWM.gears.shape.rounded_rect
})

volume_indicator_sm.init = function()
  AwesomeWM.awful.placement.right(volume_indicator_sm.wibox, { margins = base.margins })
end

volume_indicator_sm.timer = AwesomeWM.gears.timer({
  timeout = base.timeout,
  callback = function()
    volume_indicator_sm.wibox.visible = false
  end
})

volume_indicator_sm.show = function()
  AwesomeWM.functions.volume.find_volume_and(function(icon, value)
    volume_indicator_sm.icon.image = icon
    volume_indicator_sm.slider.value = value
    volume_indicator_sm.value.text = tostring(value)
    volume_indicator_sm.wibox.visible = true
    volume_indicator_sm.timer:again()
  end)
end

return volume_indicator_sm
