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
  local restart_content = ""
  restart_content = restart_content .. AwesomeWM.awful.screen.focused().selected_tag.name .. "\n"
  for _, t in ipairs(AwesomeWM.values.tags) do
    restart_content = restart_content .. t.name
    restart_content = restart_content .. " " .. t.layout.name .. "\n"
  end

  local f = io.open(AwesomeWM.values.restart_file, "w")
  if f then
    f:write(restart_content)
    f:close()
  end
  AwesomeWM.awesome.restart()
end

functions_m.check_restart_file = function()
  local f = io.open(AwesomeWM.values.restart_file, "r")
  if not f then return end

  local focused_tag
  local tag_state = {}

  for line in f:lines() do
    -- trim whitespace
    line = line:match("^%s*(.-)%s*$")

    -- first line: focused tag
    if not focused_tag then
      focused_tag = line
    else
      -- remaining lines: "<tag> <state>"
      local tag, state = line:match("^(%S+)%s+(%S+)$")
      if tag and state then
        tag_state[tag] = state
      end
    end
  end

  f:close()

  local screen = AwesomeWM.awful.screen.focused()
  for k, v in pairs(tag_state) do
    local tag = AwesomeWM.awful.tag.find_by_name(screen, k)
    tag.layout = AwesomeWM.values.layout_map[v]
  end

  local t = nil
  for k, v in ipairs(AwesomeWM.values.tags) do
    if v.name == focused_tag then
      t = v
      break
    end
  end

  if t then
    AwesomeWM.functions.tags.move_to_tag(t)
  end

  os.remove(AwesomeWM.values.restart_file)
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
