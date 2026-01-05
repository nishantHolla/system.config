local volume_sm = {}
local script = AwesomeWM.values.get_script("volume")

local run = function(cmd)
  AwesomeWM.awful.spawn.easy_async(cmd, function(stdout, stderr, error_reason, exit_code)
    if AwesomeWM.widgets.dashboard.is_visible() then
      AwesomeWM.widgets.dashboard.components.stats.refresh(screen)
    else
      AwesomeWM.widgets.indicators.volume.show(screen)
    end
  end)
end

volume_sm.increase = function()
  run(script .. " set 5%+")
end

volume_sm.decrease = function()
  run(script .. " set 5%-")
end

volume_sm.toggle = function()
  run(script .. " toggle")
end

volume_sm.mute = function()
  run(script .. " mute")
end

volume_sm.unmute = function()
  run(script .. " unmute")
end

volume_sm.find_volume_and = function(callback)
  if type(callback) ~= "function" then
    return
  end

  AwesomeWM.awful.spawn.easy_async(script .. " get", function(stdout, stderr, error_reason, exit_code)
    local volume = tonumber(stdout)
    local icon = AwesomeWM.assets.get_volume_icon(volume)

    callback(icon, volume)
  end)
end

return volume_sm
