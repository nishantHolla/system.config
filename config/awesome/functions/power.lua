local power_sm = {}

power_sm.shutdown = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  os.remove(AwesomeWM.values.restart_file)

  AwesomeWM.functions.spawn_with_shell("power-menu shutdown")
end

power_sm.restart = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  os.remove(AwesomeWM.values.restart_file)

  AwesomeWM.functions.spawn_with_shell("power-menu restart")
end

power_sm.logout = function()
  if AwesomeWM.functions.clients.has_not_to_kill() then
    return
  end
  os.remove(AwesomeWM.values.restart_file)

  AwesomeWM.functions.spawn_with_shell("power-menu logout")
end

power_sm.lock = function(display_off)
  if display_off then
    AwesomeWM.functions.spawn_with_shell("power-menu lock")
    AwesomeWM.functions.spawn_with_shell("sleep 1; xset dpms force off")
  else
    AwesomeWM.functions.spawn_with_shell("power-menu lock")
  end
end

power_sm.sleep = function()
  AwesomeWM.functions.spawn_with_shell("power-menu sleep")
end

power_sm.select = function()
  AwesomeWM.awful.spawn.easy_async("power-menu select", function(stdout, stderr, error_reason, exit_code)
    if stdout == "shutdown\n" then
      power_sm.shutdown()
    elseif stdout == "restart\n" then
      power_sm.restart()
    elseif stdout == "logout\n" then
      power_sm.logout()
    elseif stdout == "sleep\n" then
      power_sm.sleep()
    elseif stdout == "lock\n" then
      power_sm.lock()
    end
  end)
end
return power_sm
