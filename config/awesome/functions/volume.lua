local volume_sm = {}

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    -- TODO: Update volume in required places
  end)
end

volume_sm.increase = function()
  run("volume set 5%+")
end

volume_sm.decrease = function()
  run("volume set 5%-")
end

volume_sm.toggle = function()
  run("volume toggle")
end

volume_sm.mute = function()
  run("volume mute")
end

volume_sm.unmute = function()
  run("volume unmute")
end

volume_sm.fund_volume_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async("volume get", function(stdout, stderr, error_reason, exit_code)
    local volume = tonumber(stdout)
    local icon = AwesomeWM.assets.get_volume_icon(volume)

    callback(icon, volume)
  end)
end

return volume_sm
