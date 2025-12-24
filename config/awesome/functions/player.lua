local player_sm = {}

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    -- TODO: Update player in required places
  end)
end

player_sm.previous = function()
  run("player previous")
end

player_sm.next = function()
  run("player next")
end

player_sm.toggle = function()
  run("player toggle")
end

player_sm.play = function()
  run("player play")
end

player_sm.pause = function()
  run("player pause")
end

player_sm.play_tick = function()
  AwesomeWM.awful.spawn.easy_async("paplay " .. AwesomeWM.assets.get_sound("tick_sound") .. " --volume=30000", function()
  end)
end

player_sm.play_glitter = function()
  AwesomeWM.awful.spawn.easy_async("paplay " .. AwesomeWM.assets.get_sound("glitter_sound") .. " --volume=30000", function()
  end)
end

return player_sm
