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
	-- AwesomeWM.awful.spawn("paplay " .. AwesomeWM.assets.getSound("tickSound") .. " --volume=30000")
  -- TODO: Play tick sound
end

player_sm.play_glitter = function()
  -- TODO: Play glitter sound
end

return player_sm
