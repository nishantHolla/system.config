local tags_sm = {}

tags_sm.move_to_tag = function(tag)
  local screen = AwesomeWM.mouse.screen or AwesomeWM.awful.screen.focused()
  AwesomeWM.sharedtags.viewonly(tag, screen)
  AwesomeWM.theme.set_wallpaper(screen)

  AwesomeWM.widgets.overlays.client_count.refresh()
  -- AwesomeWM.widgets.overlays.client_properties.refresh()
  -- TODO: Show tag inidicator
end

tags_sm.move_client_to_tag = function(tag)
  if AwesomeWM.client.focus == nil then
    return
  end
  local screen = AwesomeWM.mouse.screen or AwesomeWM.awful.screen.focused()
  AwesomeWM.client.focus:move_to_tag(tag)
  tags_sm.move_to_tag(tag)
end

tags_sm.cycle_layout = function(order)
  AwesomeWM.awful.layout.inc(order)

  -- TODO: Show tag indicator
end

tags_sm.get_tag_state = function(tag_name)
  local selected_tag = AwesomeWM.awful.screen.focused().selected_tag.name

  if tag_name == selected_tag then
    return "active"
  end

  local current_tag = AwesomeWM.awful.tag.find_by_name(AwesomeWM.awful.screen.focused(), tag_name)
  local count = #(current_tag:clients())

  if count == 0 then
    return "dead"
  else
    return "alive"
  end
end

return tags_sm
