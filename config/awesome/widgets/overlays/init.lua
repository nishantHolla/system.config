local overlays_sm = {}

overlays_sm.client_count = require("widgets.overlays.client_count")
overlays_sm.time = require("widgets.overlays.time")
overlays_sm.client_properties = require("widgets.overlays.client_properties")

overlays_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  overlays_sm.client_count.init(screen)
  overlays_sm.time.init(screen)
  overlays_sm.client_properties.init(screen)
end

overlays_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  overlays_sm.client_count.show(screen)
  overlays_sm.time.show(screen)
  overlays_sm.client_properties.show(screen)
end

overlays_sm.hide = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  overlays_sm.client_count.hide(screen)
  overlays_sm.time.hide(screen)
  overlays_sm.client_properties.hide(screen)
end

overlays_sm.toggle = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  overlays_sm.client_count.toggle(screen)
  overlays_sm.time.toggle(screen)
  overlays_sm.client_properties.toggle(screen)
end

return overlays_sm
