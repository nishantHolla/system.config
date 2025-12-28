local widgets_m = {}

widgets_m.overlays = require("widgets.overlays")

widgets_m.init_widgets = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  widgets_m.overlays.init(screen)
end

return widgets_m
