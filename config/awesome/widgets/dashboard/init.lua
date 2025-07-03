local dashboard_sm = {}
local utils = require("widgets.dashboard.utils")

dashboard_sm.components = {
  logo = require("widgets.dashboard.components.logo"),
  system_tray = require("widgets.dashboard.components.system_tray"),
  power_options = require("widgets.dashboard.components.power_options"),
  media_player = require("widgets.dashboard.components.media_player"),
  tag_layout = require("widgets.dashboard.components.tag_layout"),
  stats = require("widgets.dashboard.components.stats"),
  notes = require("widgets.dashboard.components.notes"),
  actions = require("widgets.dashboard.components.actions"),
  date_and_time = require("widgets.dashboard.components.date_and_time"),
  user = require("widgets.dashboard.components.user")
}

dashboard_sm.center_split = AwesomeWM.wibox.widget({
  utils.make_box("Current User", dashboard_sm.components.user.main),
  utils.make_box("Date and Time", dashboard_sm.components.date_and_time.main),
  layout = AwesomeWM.wibox.layout.ratio.vertical
})

local test_widget = AwesomeWM.wibox.widget({
  text = "hello",
  widget = AwesomeWM.wibox.widget.textbox
})

dashboard_sm.left = AwesomeWM.wibox.widget({
  utils.make_box(nil, dashboard_sm.components.logo.main),
  utils.make_box("Stats", dashboard_sm.components.stats.main),
  utils.make_box("Media Player", dashboard_sm.components.media_player.main),
  layout = AwesomeWM.wibox.layout.ratio.vertical
})

dashboard_sm.middle = AwesomeWM.wibox.widget({
  utils.make_box("Tag Layout", dashboard_sm.components.tag_layout.main),
  dashboard_sm.center_split,
  utils.make_box("Actions", dashboard_sm.components.actions.main),
  layout = AwesomeWM.wibox.layout.ratio.vertical
})

dashboard_sm.right = AwesomeWM.wibox.widget({
  utils.make_box("Power Options", dashboard_sm.components.power_options.main),
  utils.make_box("Notes", dashboard_sm.components.notes.main),
  utils.make_box("System Tray", dashboard_sm.components.system_tray.main),
  layout = AwesomeWM.wibox.layout.ratio.vertical
})

dashboard_sm.main = AwesomeWM.wibox.widget({
  dashboard_sm.left,
  dashboard_sm.middle,
  dashboard_sm.right,
  layout = AwesomeWM.wibox.layout.ratio.horizontal
})


dashboard_sm.wibox = AwesomeWM.wibox({
  widget = utils.margin_box(dashboard_sm.main, 2),
  visible = false,
  opacity = 1.00,
  ontop = true,
  type = "dock",
  bg = AwesomeWM.theme.gray,
  input_passthrough = true
})

dashboard_sm.init = function()
  dashboard_sm.wibox.width = AwesomeWM.values.screen_width
  dashboard_sm.wibox.height = AwesomeWM.values.screen_height

  dashboard_sm.main:ajust_ratio(2, 0.25, 0.5, 0.25)
  dashboard_sm.left:ajust_ratio(2, 0.3, 0.4, 0.2)
  dashboard_sm.middle:ajust_ratio(2, 0.1, 0.8, 0.1)
  dashboard_sm.center_split:ajust_ratio(2, 0.5, 0.5, 0)
  dashboard_sm.right:ajust_ratio(2, 0.1, 0.8, 0.1)

  AwesomeWM.awful.placement.centered(dashboard_sm.wibox, { margins = 0 })
end

dashboard_sm.show = function()
  dashboard_sm.components.media_player.refresh()
  dashboard_sm.components.tag_layout.refresh()
  dashboard_sm.components.stats.refresh()
  dashboard_sm.components.notes.refresh()
  dashboard_sm.components.actions.refresh()
  dashboard_sm.components.user.refresh()

  dashboard_sm.wibox.visible = true
end

dashboard_sm.hide = function()
  dashboard_sm.wibox.visible = false
end

dashboard_sm.toggle = function()
  if dashboard_sm.wibox.visible then
    dashboard_sm.hide()
  else
    dashboard_sm.show()
  end
end

return dashboard_sm
