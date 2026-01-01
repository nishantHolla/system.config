local dashboard_sm = {}
local utils = require("widgets.dashboard.utils")
local v = require("widgets.values")

dashboard_sm.left = function()
  return AwesomeWM.wibox.widget({
    utils.make_box(nil, utils.make_placeholder()),
    utils.make_box("Stats", utils.make_placeholder()),
    utils.make_box("Media Player", utils.make_placeholder()),
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

dashboard_sm.center = function()
  return AwesomeWM.wibox.widget({
    utils.make_box("Current User", utils.make_placeholder()),
    utils.make_box("Date and Time", utils.make_placeholder()),
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

dashboard_sm.middle = function()
  return AwesomeWM.wibox.widget({
    utils.make_box("Tag Layout", utils.make_placeholder()),
    dashboard_sm.center(),
    utils.make_box("Actions", utils.make_placeholder()),
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

dashboard_sm.right = function()
  return AwesomeWM.wibox.widget({
    utils.make_box("Power Options", utils.make_placeholder()),
    utils.make_box("Notes", utils.make_placeholder()),
    utils.make_box("Systray", utils.make_placeholder()),
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

dashboard_sm.make_wibox = function(index)
  if dashboard_sm.instances[index] ~= nil then
    return
  end

  dashboard_sm.instances[index] = {
    left = dashboard_sm.left(),
    middle = dashboard_sm.middle(),
    right = dashboard_sm.right()
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

  dashboard_sm.make_wibox(index)
  dashboard_sm.instances[index].wibox.width = screen.geometry.width
  dashboard_sm.instances[index].wibox.height = screen.geometry.height

  dashboard_sm.instances[index].main:ajust_ratio(2, 0.25, 0.45, 0.3)
  dashboard_sm.instances[index].left:ajust_ratio(2, 0.4, 0.4, 0.2)
  dashboard_sm.instances[index].middle:ajust_ratio(2, 0.1, 0.8, 0.1)
  dashboard_sm.instances[index].right:ajust_ratio(2, 0.1, 0.8, 0.1)

  AwesomeWM.awful.placement.centered(dashboard_sm.instances[index].wibox, { margins = 0 })
end

dashboard_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if dashboard_sm.instances[index] == nil then
    return
  end

  dashboard_sm.instances[index].wibox.visible = true
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

  dashboard_sm.instances[index].wibox.visible = not dashboard_sm.instances[index].wibox.visible
end

return dashboard_sm
