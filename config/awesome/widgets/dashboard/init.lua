local dashboard_sm = {}
local utils = require("widgets.dashboard.utils")
local v = require("widgets.values")

dashboard_sm.components = {
  logo = require("widgets.dashboard.logo"),
  systray = require("widgets.dashboard.systray"),
  power = require("widgets.dashboard.power"),
  media = require("widgets.dashboard.media"),
  actions = require("widgets.dashboard.actions"),
  stats = require("widgets.dashboard.stats"),
  tags = require("widgets.dashboard.tags")
}

dashboard_sm.left = function(screen)
  return AwesomeWM.wibox.widget({
    utils.make_box(nil, dashboard_sm.components.logo.create(screen)),
    utils.make_box("Stats", dashboard_sm.components.stats.create(screen)),
    utils.make_box("Media Player", dashboard_sm.components.media.create(screen)),
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

dashboard_sm.center = function(screen)
  return AwesomeWM.wibox.widget({
    utils.make_box("Current User", utils.make_placeholder()),
    utils.make_box("Date and Time", utils.make_placeholder()),
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

dashboard_sm.middle = function(screen)
  return AwesomeWM.wibox.widget({
    utils.make_box("Tag Layout", dashboard_sm.components.tags.create(screen)),
    dashboard_sm.center(screen),
    utils.make_box("Actions", dashboard_sm.components.actions.create(screen)),
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

dashboard_sm.right = function(screen)
  return AwesomeWM.wibox.widget({
    utils.make_box("Power Options", dashboard_sm.components.power.create(screen)),
    utils.make_box("Notes", utils.make_placeholder()),
    utils.make_box("Systray", dashboard_sm.components.systray.create(screen)),
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

dashboard_sm.instances = {}

dashboard_sm.main = function(index)
  return AwesomeWM.wibox.widget({
    dashboard_sm.instances[index].left,
    dashboard_sm.instances[index].middle,
    dashboard_sm.instances[index].right,
    layout = AwesomeWM.wibox.layout.ratio.horizontal
  })
end

dashboard_sm.make_wibox = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if dashboard_sm.instances[index] ~= nil then
    return
  end

  dashboard_sm.instances[index] = {
    left = dashboard_sm.left(screen),
    middle = dashboard_sm.middle(screen),
    right = dashboard_sm.right(screen)
  }

  dashboard_sm.instances[index].main = dashboard_sm.main(index)

  dashboard_sm.instances[index].wibox = AwesomeWM.wibox({
    visible = false,
    opacity = v.dashboard_opacity,
    ontop = true,
    type = "dock",
    bg = AwesomeWM.theme.gray,
    input_passthrough = false,
    widget = utils.margin_box(dashboard_sm.instances[index].main, v.dashboard_padding)
  })
end

dashboard_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  dashboard_sm.make_wibox(screen)
  dashboard_sm.instances[index].wibox.width = screen.geometry.width
  dashboard_sm.instances[index].wibox.height = screen.geometry.height

  dashboard_sm.instances[index].main:ajust_ratio(2, 0.25, 0.45, 0.3)
  dashboard_sm.instances[index].left:ajust_ratio(2, 0.4, 0.4, 0.2)
  dashboard_sm.instances[index].middle:ajust_ratio(2, 0.1, 0.8, 0.1)
  dashboard_sm.instances[index].right:ajust_ratio(2, 0.1, 0.8, 0.1)

  AwesomeWM.awful.placement.centered(dashboard_sm.instances[index].wibox, { margins = 0, parent = screen })
end

dashboard_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if dashboard_sm.instances[index] == nil then
    return
  end

  dashboard_sm.instances[index].wibox.visible = true
  dashboard_sm.components.media.refresh(screen)
  dashboard_sm.components.stats.refresh(screen)
  dashboard_sm.components.tags.refresh(screen)
end

dashboard_sm.hide = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if dashboard_sm.instances[index] == nil then
    return
  end

  dashboard_sm.instances[index].wibox.visible = false
end

dashboard_sm.toggle = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if dashboard_sm.instances[index] == nil then
    return
  end

  if dashboard_sm.instances[index].wibox.visible then
    dashboard_sm.hide(screen)
  else
    dashboard_sm.show(screen)
  end
end

dashboard_sm.is_visible = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if dashboard_sm.instances[index] == nil then
    return false
  end

  return dashboard_sm.instances[index].wibox.visible == true
end

return dashboard_sm
