local screens_sm = {}

screens_sm.init_screens = function()
  AwesomeWM.screen.connect_signal("property::geometry", AwesomeWM.theme.set_wallpaper)

  AwesomeWM.awful.screen.connect_for_each_screen(function(screen)
    AwesomeWM.sharedtags.viewonly(AwesomeWM.values.tags[1], screen)
    AwesomeWM.theme.set_wallpaper(screen)
  end)
end

return screens_sm
