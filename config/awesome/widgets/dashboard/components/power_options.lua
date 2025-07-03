local power_component = {}
local utils = require("widgets.dashboard.utils")

power_component.shutdown_button = utils.make_icon_button("powerShutdown", function()
  AwesomeWM.functions.power.shutdown()
end)

power_component.restart_button = utils.make_icon_button("powerRestart", function()
  AwesomeWM.functions.power.reboot()
end)

power_component.lock_button = utils.make_icon_button("powerLock", function()
  AwesomeWM.functions.power.lock()
end)

power_component.sleep_button = utils.make_icon_button("powerSleep", function()
  AwesomeWM.functions.power.sleep()
end)

power_component.logout_button = utils.make_icon_button("powerLogout", function()
  AwesomeWM.functions.power.logout()
end)

power_component.power_options = AwesomeWM.wibox.widget({
  {
    power_component.shutdown_button.main,
    power_component.restart_button.main,
    power_component.lock_button.main,
    power_component.sleep_button.main,
    power_component.logout_button.main,
    spacing = 20,
    layout = AwesomeWM.wibox.layout.fixed.horizontal
  },
  halign = 'center',
  widget = AwesomeWM.wibox.container.place
})

power_component.main = utils.margin_box(power_component.power_options, 7)
return power_component

