local widget_values_sm = {}

widget_values_sm.overlays_bg = "#000000"
widget_values_sm.overlays_opacity = 0.8
widget_values_sm.overlays_height = 15
widget_values_sm.overlays_font = AwesomeWM.theme.default_font .. " 7"

widget_values_sm.indicator_length = 360
widget_values_sm.indicator_width = 60
widget_values_sm.indicator_margins = 5
widget_values_sm.indicator_timeout = 1
widget_values_sm.indicator_opacity = 0.8
widget_values_sm.indicator_bg = "#111111"
widget_values_sm.indicator_inner_margins = 10
widget_values_sm.indicator_padding = 5
widget_values_sm.indicator_slider_outer_color = AwesomeWM.theme.white
widget_values_sm.indicator_font = AwesomeWM.theme.default_font .. " 14"

widget_values_sm.indicator_shape = function(c, w, h)
  AwesomeWM.gears.shape.rounded_rect(c, w, h, 100)
end

return widget_values_sm
