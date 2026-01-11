local client_count_sm = {}
local v = require("widgets.values")

client_count_sm.background_color = v.overlays_bg
client_count_sm.opacity = v.overlays_opacity
client_count_sm.height = v.overlays_height
client_count_sm.width = 20
client_count_sm.font = v.overlays_font

client_count_sm.main = function()
  return AwesomeWM.wibox.widget({
    text = "0:0",
    align = "center",
    valign = "center",
    font = client_count_sm.font,
    widget = AwesomeWM.wibox.widget.textbox
  })
end

client_count_sm.instances = {}

client_count_sm.make_wibox = function(index)
  if client_count_sm.instances[index] ~= nil then
    return
  else
    client_count_sm.instances[index] = {}
  end

  client_count_sm.instances[index].main = client_count_sm.main()

  client_count_sm.instances[index].wibox = AwesomeWM.wibox({
    widget = client_count_sm.instances[index].main,
    visible = true,
    opacity = client_count_sm.opacity,
    ontop = true,
    type = "desktop",
    bg = client_count_sm.background_color,
    width = client_count_sm.width,
    height = client_count_sm.height
  })
end

client_count_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  client_count_sm.make_wibox(index)
  AwesomeWM.awful.placement.top_left(client_count_sm.instances[index].wibox, { margins = 0, parent = screen })

  client_count_sm.refresh(screen)
end

client_count_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if client_count_sm.instances[index] == nil then
    return
  end

  client_count_sm.instances[index].wibox.visible = true
end

client_count_sm.hide = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if client_count_sm.instances[index] == nil then
    return
  end

  client_count_sm.instances[index].wibox.visible = false
end

client_count_sm.toggle = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if client_count_sm.instances[index] == nil then
    return
  end

  client_count_sm.instances[index].wibox.visible = not client_count_sm.instances[index].wibox.visible
end

client_count_sm.refresh = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  local client_count = AwesomeWM.functions.clients.get_client_count()
  local text = tostring(client_count.local_count) .. ":" .. tostring(client_count.global_count)
  client_count_sm.instances[index].main.text = text
end

return client_count_sm
