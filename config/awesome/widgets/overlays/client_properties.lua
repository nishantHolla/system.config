local client_properties_sm = {}
local v = require("widgets.values")

client_properties_sm.background_color = v.overlays_bg
client_properties_sm.opacity = v.overlays_opacity
client_properties_sm.height = v.overlays_height
client_properties_sm.width = 80
client_properties_sm.font = v.overlays_font

client_properties_sm.main = function()
  return AwesomeWM.wibox.widget({
    text = "",
    align = "left",
    valign = "center",
    font = client_properties_sm.font,
    widget = AwesomeWM.wibox.widget.textbox
  })
end

client_properties_sm.instances = {}

client_properties_sm.make_wibox = function(index)
  if client_properties_sm.instances[index] ~= nil then
    return
  else
    client_properties_sm.instances[index] = {}
  end

  client_properties_sm.instances[index].main = client_properties_sm.main()

  client_properties_sm.instances[index].wibox = AwesomeWM.wibox({
    widget = client_properties_sm.instances[index].main,
    visible = true,
    opacity = client_properties_sm.opacity,
    ontop = true,
    type = "desktop",
    bg = client_properties_sm.background_color,
    width = client_properties_sm.width,
    height = client_properties_sm.height
  })
end

client_properties_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  client_properties_sm.make_wibox(index)
  AwesomeWM.awful.placement.top_right(client_properties_sm.instances[index].wibox, { margin = 0, parent = screen })

  client_properties_sm.refresh(screen)
end

client_properties_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if client_properties_sm.instances[index] == nil then
    return
  end

  client_properties_sm.instances[index].wibox.visible = true
end

client_properties_sm.hide = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if client_properties_sm.instances[index] == nil then
    return
  end

  client_properties_sm.instances[index].wibox.visible = false
end

client_properties_sm.toggle = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if client_properties_sm.instances[index] == nil then
    return
  end

  client_properties_sm.instances[index].wibox.visible = not client_properties_sm.instances[index].wibox.visible
end

client_properties_sm.refresh = function(screen, client)
  screen = screen or AwesomeWM.mouse.screen
  client = client or AwesomeWM.client.focus
  local index = tostring(screen.index)

  if not client then
    client_properties_sm.instances[index].main.text = ""
    return
  end

  local property_count = 0
  local text = ""

  if client.not_to_kill then
    text = text .. " N |"
    property_count = property_count + 1
  end

  if client.floating then
    text = text .. " F |"
    property_count = property_count + 1
  end

  if client.fullscreen then
    text = text .. " M |"
    property_count = property_count + 1
  end

  if client.sticky then
    text = text .. " S |"
    property_count = property_count + 1
  end

  if client.ontop then
    text = text .. " O |"
    property_count = property_count + 1
  end

  client_properties_sm.instances[index].main.text = text
end

return client_properties_sm
