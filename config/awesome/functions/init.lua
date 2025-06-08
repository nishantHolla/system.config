local functions_m = {}

-- Initialze error handling service
functions_m.init_error_handling = function()
  -- Startup errors
  if AwesomeWM.awesome.startup_errors then
    AwesomeWM.notify.critical("Startup error encountered", AwesomeWM.awesome.startup_errors)
  end

  -- Runtime errors
  do
    local in_error = false
    AwesomeWM.awesome.connect_signal("debug::error", function(err)
      if in_error then return end
      in_error = true

      AwesomeWM.notify.critical("Runtime error encountered", tostring(err))
      in_error = false
    end)
  end
end

-- Initialize screens
functions_m.init_screens = function()
  -- Reapply wallpaper on geometry change
  AwesomeWM.screen.connect_signal("property::geometry", AwesomeWM.theme.set_wallpaper)

  -- Initialze tags for each screen
  AwesomeWM.awful.screen.connect_for_each_screen(function(screen)
    local tags = {}
    for _, t in pairs(AwesomeWM.values.tags) do
      table.insert(tags, t.name)
    end
    AwesomeWM.awful.tag(tags, screen, AwesomeWM.values.tag_layouts[1])
    AwesomeWM.theme.set_wallpaper()
  end)

end

return functions_m
