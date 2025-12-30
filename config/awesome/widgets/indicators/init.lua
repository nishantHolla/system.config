local indicators_sm = {}

indicators_sm.brightness = require("widgets.indicators.brightness")

indicators_sm.init = function()
  indicators_sm.brightness.init()
end

return indicators_sm
