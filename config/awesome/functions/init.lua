local functions_m = {}

functions_m.init_error_handling = function()
  -- startup errors
  if AwesomeWM.awesome.startup_errors then
    AwesomeWM.notify.critical(
      "Startup error encountered",
      AwesomeWM.awesome.startup_errors
    )
  end

  -- runtime errors
  do
    local in_error = false
    AwesomeWM.awesome.connect_signal("debug:error", function(error_msg)
      if in_error then return end
      in_error = true
      AwesomeWM.notify.critical(
        "Runtime error encountered",
        tostring(error_msg)
      )
      in_error = false
    end)
  end
end

return functions_m
