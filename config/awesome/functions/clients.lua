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
        screen = AwesomeWM.mouse.screen,
        placement = AwesomeWM.awful.placement.no_overlap + AwesomeWM.awful.placement.no_offscreen,
        size_hints_honor = true
      }
    },
    {
      rule = { class = "Dragon-drop" },
      description = "Rule for dragon drop",
      properties = {
        floating = true,
        ontop = true,
        placement = AwesomeWM.awful.placement.top_right
      }
    }
  }

  AwesomeWM.client.connect_signal("unmanage", function(client)
    -- TODO: Update client count
  end)

  AwesomeWM.client.connect_signal("manage", function(client)
    if AwesomeWM.awesome.startup
      and not client.size_hints.user_position
      and not client.size_hints.program_position
    then
      AwesomeWM.awful.placement.no_offscreen(client)

      -- TODO: Update client count
    end
  end)

  AwesomeWM.client.connect_signal("mouse::enter", function(client)
    client:emit_signal("request::activate", "mouse_enter", {raise = false})
  end)

  AwesomeWM.client.connect_signal("focus", function(client)
    -- TODO: Update client properties
    clients_sm.apply_border_color(client)
  end)

  AwesomeWM.client.connect_signal("unfocus", function(client)
    -- TODO: Update client properties
    client.border_color = AwesomeWM.beautiful.border_normal
  end)
end

clients_sm.get_client_count = function()
  local local_count = #(AwesomeWM.awful.screen.focused().selected_tag:clients())
  local global_count = #(AwesomeWM.client.get())
  -- TODO: Check this

  return { local_count = local_count, global_count = global_count }
end

clients_sm.toggle_client_property = function(property_name)
  local focused_client = AwesomeWM.client.focus
  local focused_tag = AwesomeWM.awful.screen.focused().selected_tag

  if focused_client == nil or focused_tag == nil then
    return
  end

  focused_client[property_name] = not focused_client[property_name]
  if focused_client.sticky == false then
    focused_client:move_to_tag(focused_tag)
  end

  clients_sm.apply_border_color(focused_client)
  -- TODO: Update client properties
end

clients_sm.apply_border_color = function(client)
  client = client or AwesomeWM.client.focus
  if client == nil then
    return
  end

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

clients_sm.close_focused_client = function()
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
