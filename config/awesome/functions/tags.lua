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
  -- TODO: Update client properites
  -- TODO: Show tag
end

tags_sm.move_client_to_tag = function(tag_name)
  local focused_screen = AwesomeWM.awful.screen.focused()
  local tag = AwesomeWM.awful.tag.find_by_name(focused_screen, t.name)
  if AwesomeWM.client.focus == nil then return end
  AwesomeWM.client.focus:move_to_tag(tag)
  AwesomeWM.functions.tag.move_to_tag(t.name)
end

tags_sm.cycle_layout = function(order)
  AwesomeWM.awful.layout.inc(order)

  -- TODO: Update tags in pages
  -- TODO: Show tag
end


return tags_sm
