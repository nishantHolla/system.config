local client_properites_sm = {}

client_properites_sm.width = 80
client_properites_sm.height = 15
client_properites_sm.opacity = 0.8
client_properites_sm.background_color = "#000000"

client_properites_sm.main = AwesomeWM.wibox.widget({
  text = "0",
  align = "left",
  valign = "center",
  font = AwesomeWM.theme.default_font .. " 7",
  widget = AwesomeWM.wibox.widget.textbox
})

client_properites_sm.wibox = AwesomeWM.wibox({
  widget = client_properites_sm.main,
  visible = true,
  opacity = client_properites_sm.opacity,
  ontop = true,
  type = "desktop",
  bg = client_properites_sm.background_color,
  width = client_properites_sm.width,
  height = client_properites_sm.height
})

client_properites_sm.init = function()
  AwesomeWM.awful.placement.top_right(client_properites_sm.wibox, { margin = 0 })
  client_properites_sm.refresh()
end

client_properites_sm.show = function()
  client_properites_sm.wibox.visible = true
end

client_properites_sm.hide = function()
  client_properites_sm.wibox.visible = false
end

client_properites_sm.toggle = function()
  client_properites_sm.wibox.visible = not client_properites_sm.wibox.visible
end

client_properites_sm.refresh = function(client)
  client = client or AwesomeWM.client.focus
  if not client then
    client_properites_sm.main.text = ""
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

  client_properites_sm.main.text = text
end

return client_properites_sm
