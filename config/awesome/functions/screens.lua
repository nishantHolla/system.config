local screens_sm = {}

screens_sm.init_screens = function()
  AwesomeWM.screen.connect_signal("property::geometry", AwesomeWM.theme.set_wallpaper)

  AwesomeWM.awful.screen.connect_for_each_screen(function(screen)
    local tags = {}
    for _, t in pairs(AwesomeWM.values.tags) do
      table.insert(tags, t.name)
    end

    AwesomeWM.awful.tag(tags, screen, AwesomeWM.values.tag_layouts[1])
    AwesomeWM.theme.set_wallpaper()
  end)
end

return screens_sm
