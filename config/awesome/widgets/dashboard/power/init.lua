local power_component = {}
local utils = require("widgets.dashboard.utils")

power_component.shutdown_button = function()
  return utils.make_icon_button("powerShutdown", function()
    AwesomeWM.functions.power.shutdown()
    AwesomeWM.widgets.dashboard.hide()
  end)
end

power_component.restart_button = function()
  return utils.make_icon_button("powerRestart", function()
    AwesomeWM.functions.power.reboot()
    AwesomeWM.widgets.dashboard.hide()
  end)
end

power_component.lock_button = function()
  return utils.make_icon_button("powerLock", function()
    AwesomeWM.functions.power.lock()
    AwesomeWM.widgets.dashboard.hide()
  end)
end

power_component.sleep_button = function()
  return utils.make_icon_button("powerSleep", function()
    AwesomeWM.functions.power.sleep()
    AwesomeWM.widgets.dashboard.hide()
  end)
end

power_component.logout_button = function()
  return utils.make_icon_button("powerLogout", function()
    AwesomeWM.functions.power.logout()
    AwesomeWM.widgets.dashboard.hide()
  end)
end

power_component.instances = {}

power_component.main = function(index)
  return AwesomeWM.wibox.widget({
    {
      {
        power_component.instances[index].shutdown_button.main,
        power_component.instances[index].restart_button.main,
        power_component.instances[index].lock_button.main,
        power_component.instances[index].sleep_button.main,
        power_component.instances[index].logout_button.main,
        spacing = 20,
        layout = AwesomeWM.wibox.layout.fixed.horizontal
      },
      margins = 5,
      widget = AwesomeWM.wibox.container.margin
    },
    halign = "center",
    widget = AwesomeWM.wibox.container.place
  })
end

power_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if power_component.instances[index] ~= nil then
    return power_component.instances[index].main
  end

  power_component.instances[index] = {
    shutdown_button = power_component.shutdown_button(),
    restart_button = power_component.restart_button(),
    lock_button = power_component.lock_button(),
    sleep_button = power_component.sleep_button(),
    logout_button = power_component.logout_button()
  }

  power_component.instances[index].main = power_component.main(index)
  return power_component.instances[index].main
end

return power_component
