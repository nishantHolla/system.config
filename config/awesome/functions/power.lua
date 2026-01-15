local power_sm = {}

power_sm.shutdown = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  os.remove(AwesomeWM.values.restart_file)

  AwesomeWM.functions.spawn_with_shell("shutdown now")
end

power_sm.reboot = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  os.remove(AwesomeWM.values.restart_file)

  AwesomeWM.functions.spawn_with_shell("reboot")
end

power_sm.logout = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  os.remove(AwesomeWM.values.restart_file)

  AwesomeWM.functions.spawn_with_shell("kill -9 -1")
end

power_sm.lock = function(display_off)
  if display_off then
    AwesomeWM.functions.spawn_with_shell("XSECURELOCK_BLANK_TIMEOUT=0 XSECURELOCK_DPMS_TIMEOUT=0 xsecurelock")
  else
    AwesomeWM.functions.spawn_with_shell("XSECURELOCK_NO_DPMS=1 XSECURELOCK_NO_BLANK=1 xsecurelock")
  end
end

power_sm.sleep = function()
  AwesomeWM.functions.spawn_with_shell("systemctl suspend && xsecurelock")
end

return power_sm
