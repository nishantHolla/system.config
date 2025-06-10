local overlays_sm = {}

overlays_sm.time = require("widgets.overlays.time")
overlays_sm.client_count = require("widgets.overlays.client_count")
overlays_sm.client_properties = require("widgets.overlays.client_properties")

overlays_sm.init = function()
  overlays_sm.time.init()
  overlays_sm.client_count.init()
  overlays_sm.client_properties.init()
end

overlays_sm.show = function()
  overlays_sm.time.show()
  overlays_sm.client_count.show()
  overlays_sm.client_properties.show()
end

overlays_sm.hide = function()
  overlays_sm.time.hide()
  overlays_sm.client_count.hide()
  overlays_sm.client_properties.hide()
end

overlays_sm.toggle = function()
  overlays_sm.time.toggle()
  overlays_sm.client_count.toggle()
  overlays_sm.client_properties.toggle()
end

return overlays_sm
