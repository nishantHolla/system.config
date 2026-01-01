local player_sm = {}
local script = AwesomeWM.values.get_script("player")

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    -- TODO: Update player in required places
  end)
end

player_sm.previous = function()
  run(script .. " previous")
end

player_sm.next = function()
  run(script .. " next")
end

player_sm.toggle = function()
  run(script .. " toggle")
end

player_sm.play = function()
  run(script .. " play")
end

player_sm.pause = function()
  run(script .. " pause")
end

player_sm.play_tick = function()
  AwesomeWM.awful.spawn.easy_async("paplay " .. AwesomeWM.assets.get_sound("tick_sound") .. " --volume=30000", function()
  end)
end

player_sm.play_glitter = function()
  AwesomeWM.awful.spawn.easy_async("paplay " .. AwesomeWM.assets.get_sound("glitter_sound") .. " --volume=30000", function()
  end)
end

player_sm.find_metadata_and = function(key, callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(script .. " get-" .. key, function(stdout, stderr, error_reason, exit_code)
    AwesomeWM.notify.normal("q", script)
    stdout = stdout:sub(1, -2)
    callback(stdout)
  end)
end

return player_sm
