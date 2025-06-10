local client_count_sm = {}

client_count_sm.background_color = "#000000"
client_count_sm.opacity = 0.8
client_count_sm.height = 15
client_count_sm.width = 30

client_count_sm.main = AwesomeWM.wibox.widget({
  text = "0:0",
  align = "center",
  valign = "center",
  font = AwesomeWM.beautiful.font,
  widget = AwesomeWM.wibox.widget.textbox
})

client_count_sm.wibox = AwesomeWM.wibox({
  widget = client_count_sm.main,
  visible = true,
  opacity = client_count_sm.opacity,
  ontop = true,
  type = "desktop",
  bg = client_count_sm.background_color,
  width = client_count_sm.width,
  height = client_count_sm.height,
})

client_count_sm.init = function()
  AwesomeWM.awful.placement.top_left(client_count_sm.wibox, { margins = 0 })
  client_count_sm.refresh()
end

client_count_sm.show = function()
  client_count_sm.wibox.visible = true
end

client_count_sm.hide = function()
  client_count_sm.wibox.visible = false
end

client_count_sm.toggle = function()
  client_count_sm.wibox.visible = not client_count_sm.wibox.visible
end

client_count_sm.refresh = function()
  local client_count = AwesomeWM.functions.clients.get_client_count()
  local text = tostring(client_count.local_count) .. ":" .. tostring(client_count.global_count)
  client_count_sm.main.text = text
end

return client_count_sm
