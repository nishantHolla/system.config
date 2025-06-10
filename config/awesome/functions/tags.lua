local tags_sm = {}

tags_sm.move_to_tag = function(tag_name)
  local focused_screen = AwesomeWM.awful.screen.focused()
  local tag = AwesomeWM.awful.tag.find_by_name(focused_screen, tag_name)

  if tag_name == "next" then
    AwesomeWM.awful.tag.viewnext(focused_screen)
  elseif tag_name == "previous" then
    AwesomeWM.awful.tag.viewprev(focused_screen)
  elseif tag_name then
    tag:view_only()
  end

  AwesomeWM.theme.set_wallpaper()
  AwesomeWM.widgets.overlays.client_count.refresh()
  -- TODO: Update tags in pages
  AwesomeWM.widgets.overlays.client_properties.refresh()
  AwesomeWM.widgets.indicators.tags.show()
end

tags_sm.move_client_to_tag = function(tag_name)
  local focused_screen = AwesomeWM.awful.screen.focused()
  local tag = AwesomeWM.awful.tag.find_by_name(focused_screen, tag_name)
  if AwesomeWM.client.focus == nil then return end
  AwesomeWM.client.focus:move_to_tag(tag)
  tags_sm.move_to_tag(tag_name)
end

tags_sm.cycle_layout = function(order)
  AwesomeWM.awful.layout.inc(order)

  -- TODO: Update tags in pages
  AwesomeWM.widgets.indicators.tags.show()
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
