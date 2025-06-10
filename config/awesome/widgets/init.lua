local widgets_m = {}

widgets_m.overlays = require("widgets.overlays")
widgets_m.indicators = require("widgets.indicators")

widgets_m.init_widgets = function()
  widgets_m.overlays.init()
  widgets_m.indicators.init()
end

return widgets_m
