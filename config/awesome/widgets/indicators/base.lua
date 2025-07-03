local indicator_base_sm = {}

indicator_base_sm.height = 360
indicator_base_sm.width = 60
indicator_base_sm.margins = 5
indicator_base_sm.timeout = 1
indicator_base_sm.opacity = 0.8
indicator_base_sm.background = "#111111"
indicator_base_sm.padding = 5
indicator_base_sm.inner_margins = 10
indicator_base_sm.slider_outer_color = AwesomeWM.theme.white

indicator_base_sm.shape = function(c, w, h)
  AwesomeWM.gears.shape.rounded_rect(c, w, h, 100)
end

return indicator_base_sm
