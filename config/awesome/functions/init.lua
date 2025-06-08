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

return functions_m
