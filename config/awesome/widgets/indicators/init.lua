local indicators_sm = {}

indicators_sm.brightness = require("widgets.indicators.brightness")
indicators_sm.volume = require("widgets.indicators.volume")
indicators_sm.tags = require("widgets.indicators.tags")

indicators_sm.init = function()
  indicators_sm.brightness.init()
  indicators_sm.volume.init()
  indicators_sm.tags.init()

  indicators_sm.brightness.show()
  indicators_sm.volume.show()
  indicators_sm.tags.show()
end

return indicators_sm
