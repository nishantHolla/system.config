local player_sm = {}

player_sm.script = AwesomeWM.values.get_script("player")

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd)
end

player_sm.previous = function()
  run(player_sm.script .. " previous")
end

player_sm.next = function()
  run(player_sm.script .. " next")
end

player_sm.toggle = function()
  run(player_sm.script .. " toggle")
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
