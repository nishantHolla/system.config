local power_sm = {}

power_sm.shutdown = function()
  -- TODO: Check if client has not_to_kill
  -- TODO: Remove restart file

  AwesomeWM.functions.spawn_with_shell("shutdown now")
end

power_sm.reboot = function()
  -- TODO: Check if client has not_to_kill
  -- TODO: Remove restart file

  AwesomeWM.functions.spawn_with_shell("reboot")
end

power_sm.logout = function()
  -- TODO: Check if client has not to kill
  -- TODO: Remove restart file

  AwesomeWM.functions.spawn_with_shell("kill -9 -1")
end

power_sm.lock = function(display_off)
  if display_off then
    AwesomeWM.functions.spawn_with_shell("xsecurelock & sleep 1 && xset dpms force off")
  else
    AwesomeWM.functions.spawn_with_shell("xsecurelock")
  end
end

power_sm.sleep = function()
  AwesomeWM.functions.spawn_with_shell("systemctl suspend && xsecurelock")
end

return power_sm
