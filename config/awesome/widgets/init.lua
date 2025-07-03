local widgets_m = {}

widgets_m.overlays = require("widgets.overlays")
widgets_m.indicators = require("widgets.indicators")
widgets_m.low_battery = require("widgets.low_battery")
widgets_m.dashboard = require("widgets.dashboard")

widgets_m.init_widgets = function()
  widgets_m.overlays.init()
  widgets_m.indicators.init()
  widgets_m.low_battery.init()
  widgets_m.dashboard.init()
end

return widgets_m
