local functions_m = {}

functions_m.init_error_handling = function()
  -- startup errors
  if AwesomeWM.awesome.startup_errors then
    AwesomeWM.notify.critical(
      "Startup errors encountered",
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

functions_m.restart = function()
  -- TODO: Save state for restart
  AwesomeWM.awesome.restart()
end

functions_m.spawn = function(application, options)
  if options then
    if options.tag == nil then
      options.tag = AwesomeWM.awful.screen.focused().selected_tag
    end
  else
    options = { tag = AwesomeWM.awful.screen.focused().selected_tag }
  end

  AwesomeWM.awful.spawn(application, options)
end

functions_m.spawn_with_shell = function(command)
  AwesomeWM.awful.spawn.with_shell(command)
end

functions_m.is_file= function(file_path)
  local f = io.open(file_path, "r")

  if f ~= nil then
    io.close(f)
    return true
  end

  return false
end

functions_m.spawn_once = function(command, application)
  application = application or command
  local check = "ps aux | grep \"" .. application .. "\" | grep -v \"grep\" | wc -l"

  AwesomeWM.awful.spawn.easy_async_with_shell(check, function(stdout)
    if tonumber(stdout) == 0 then
      functions_m.spawn(command);
    end
  end)
end

-- Sub modules

functions_m.screens = require("functions.screens")
functions_m.power = require("functions.power")
functions_m.volume = require("functions.volume")
functions_m.brightness = require("functions.brightness")
functions_m.player = require("functions.player")
functions_m.clients = require("functions.clients")
functions_m.tags = require("functions.tags")
functions_m.battery = require("functions.battery")
functions_m.storage = require("functions.storage")
functions_m.user = require("functions.user")

return functions_m
