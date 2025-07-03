local actions_component = {}
local utils = require("widgets.dashboard.utils")

-- Notification sound
actions_component.notification_sound = {}

actions_component.notification_sound.main = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_icon("notificationOn"),
  resize = true,
  widget = AwesomeWM.wibox.widget.imagebox
})

actions_component.notification_sound.refresh = function()
  if AwesomeWM.notify.silence then
    actions_component.notification_sound.main.image = AwesomeWM.assets.get_icon("notificationOff")
  elseif AwesomeWM.notify.quiet then
    actions_component.notification_sound.main.image = AwesomeWM.assets.get_icon("notification")
  else
    actions_component.notification_sound.main.image = AwesomeWM.assets.get_icon("notificationOn")
  end
end

utils.add_button_actions(actions_component.notification_sound.main, function()
  if AwesomeWM.notify.silence then
    AwesomeWM.notify.silence = false
    AwesomeWM.notify.quiet = false
  elseif AwesomeWM.notify.quiet then
    AwesomeWM.notify.silence = true
    AwesomeWM.notify.quiet = false
  else
    AwesomeWM.notify.silence = false
    AwesomeWM.notify.quiet = true
  end

  actions_component.notification_sound.refresh()
end)

actions_component.main = AwesomeWM.wibox.widget({
  {
    actions_component.notification_sound.main,
    margins = 10,
    widget = AwesomeWM.wibox.container.margin
  },
  spacing = 10,
  layout = AwesomeWM.wibox.layout.fixed.horizontal
})

actions_component.refresh = function()
  actions_component.notification_sound.refresh()
end

return actions_component
