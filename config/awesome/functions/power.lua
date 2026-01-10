local power_sm = {}

power_sm.shutdown = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  -- TODO: Remove restart file

  AwesomeWM.functions.spawn_with_shell("shutdown now")
end

power_sm.reboot = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  -- TODO: Remove restart file

  AwesomeWM.functions.spawn_with_shell("reboot")
end

power_sm.logout = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  -- TODO: Remove restart file

  AwesomeWM.functions.spawn_with_shell("kill -9 -1")
end

power_sm.lock = function(display_off)
  if display_off then
    AwesomeWM.functions.spawn_with_shell("xsecurelock & sleep 0.3 && xset dpms force off")
  else
    AwesomeWM.functions.spawn_with_shell("xsecurelock")
  end
end

power_sm.sleep = function()
  AwesomeWM.functions.spawn_with_shell("systemctl suspend && xsecurelock")
end

return power_sm
