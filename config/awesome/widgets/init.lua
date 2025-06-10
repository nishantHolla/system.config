local widgets_m = {}

widgets_m.overlays = require("widgets.overlays")

widgets_m.init_widgets = function()
  widgets_m.overlays.init()
end

return widgets_m
