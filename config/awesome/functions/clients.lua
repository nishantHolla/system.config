local clients_sm = {}

clients_sm.init_clients = function()
  AwesomeWM.awful.rules.rules = {
    {
      rule = {},
      description = "Rule for all clients",
      properties = {
        border_width = AwesomeWM.beautiful.border_width,
        border_color = AwesomeWM.beautiful.border_normal,
        focus = AwesomeWM.awful.client.focus.filter,
        raise = true,
        buttons = AwesomeWM.keymaps.get_client_buttons(),
        screen = AwesomeWM.awful.screen.preferred,
        placement = AwesomeWM.awful.placement.no_overlap + AwesomeWM.awful.placement.no_offscreen,
        size_hints_honor = true
      }
    }
  },

  AwesomeWM.client.connect_signal("unmanage", function(client)
    -- TODO: Update client count
  end)

  AwesomeWM.client.connect_signal("manage", function(client)
    if
      AwesomeWM.awesome.startup
      and not client.size_hints.user_position
      and not client.size_hints.program_position
    then
      AwesomeWM.awful.placement.no_offscreen(client)
    end

    -- TODO: Update client count
  end)

  AwesomeWM.client.connect_signal("mouse::enter", function(client)
    client:emit_signal("request::activate", "mouse_enter", { raise = false })
  end)

  AwesomeWM.client.connect_signal("focus", function(client)
    -- TODO: Update client properties
    clients_sm.apply_border_color(client)
  end)

  AwesomeWM.client.connect_signal("unfocus", function(client)
    -- TODO: Update client properties
    client.border_color  = AwesomeWM.beautiful.border_normal
  end)

  -- Startup applications
end

clients_sm.get_client_count = function()
  local local_count = #(AwesomeWM.awful.screen.focused().selected_tag:clients())
  local global_count = 0
  for _, _ in ipairs(AwesomeWM.cleint.get()) do
    global_count = global_count + 1
  end

  return { local_count = local_count, global_count = global_count }
end

clients_sm.toggle_client_property = function(property_name)
  local focused_client = AwesomeWM.client.focus
  local focused_tag = AwesomeWM.awful.screen.focused().selected_tag

  if focused_client == nil then return end
  focused_client[property_name] = not focused_client[property_name]
  if focused_client.sticky == false then
    focused_client:move_to_tag(focused_tag)
  end

  client_sm.apply_border_color(focused_client)
  -- TODO: Update client properties
end

clients_sm.apply_border_color = function(client)
  if client.not_to_kill then
    client.border_color = AwesomeWM.beautiful.white
  elseif client.floating then
    client.border_color = AwesomeWM.beautiful.border_floating
  elseif client.sticky then
    client.border_color = AwesomeWM.beautiful.border_sticky
  elseif client.fullscreen then
    client.border_color = AwesomeWM.beautiful.border_fullscreen
  else
    client.border_color = AwesomeWM.beautiful.border_focus
  end
end

clients_sm.close = function()
  if not AwesomeWM.client.focus then
    return
  end

  if AwesomeWM.client.focus.not_to_kill then
    return
  end

  AwesomeWM.client.focus:kill()
end

clients_sm.has_not_to_kill = function()
	for _, c in ipairs(AwesomeWM.client.get()) do
		if c.not_to_kill then
			return true
		end
	end

	return false
end

return clients_sm
