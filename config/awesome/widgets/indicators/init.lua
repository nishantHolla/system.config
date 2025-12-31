local indicators_sm = {}

indicators_sm.brightness = require("widgets.indicators.brightness")
indicators_sm.volume = require("widgets.indicators.volume")
indicators_sm.tags = require("widgets.indicators.tags")

indicators_sm.init = function(screen)
  indicators_sm.brightness.init(screen)
  indicators_sm.volume.init(screen)
  indicators_sm.tags.init(screen)
end

return indicators_sm
