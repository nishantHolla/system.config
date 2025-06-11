local volume_sm = {}

volume_sm.script = AwesomeWM.values.get_script("volume")

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    -- TODO: Update dashboard stats
    AwesomeWM.widgets.indicators.volume.show()
  end)
end

volume_sm.get = function()
  return (volume_sm.script .. " get")
end

volume_sm.increase = function()
  run(volume_sm.script .. " set 5%+")
end

volume_sm.decrease = function()
  run(volume_sm.script .. " set 5%-")
end

volume_sm.toggle = function()
  run(volume_sm.script .. " toggle")
end

volume_sm.mute = function()
  run(volume_sm.script .. " mute")
end

volume_sm.unmute = function()
  run(volume_sm.script .. " unmute")
end

volume_sm.find_volume_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(volume_sm.get(), function(stdout, stderr, error_reason, exit_code)
    local volume = tonumber(stdout)
    local icon = AwesomeWM.assets.get_volume_icon(volume)

    callback(icon, volume)
  end)
end

return volume_sm
