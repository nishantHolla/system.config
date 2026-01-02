local actions_component = {}
local utils = require("widgets.dashboard.utils")

actions_component.notification_sound = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_icon("notificationOn"),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

actions_component.instances = {}

actions_component.main = function(index)
  return AwesomeWM.wibox.widget({
    {
      actions_component.instances[index].notification_sound,
      margins = 10,
      widget = AwesomeWM.wibox.container.margin
    },
    spacing = 10,
    layout = AwesomeWM.wibox.layout.fixed.horizontal
  })
end

actions_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if actions_component.instances[index] ~= nil then
    return actions_component.instances[index].main
  end

  actions_component.instances[index] = {
    notification_sound = actions_component.notification_sound()
  }

  utils.add_button_actions(actions_component.instances[index].notification_sound, function()
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

    actions_component.refresh(screen)
  end)

  actions_component.instances[index].main = actions_component.main(index)
  actions_component.refresh(screen)
  return actions_component.instances[index].main
end

actions_component.refresh = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if AwesomeWM.notify.silence then
    actions_component.instances[index].notification_sound.image = AwesomeWM.assets.get_icon("notificationOff")
  elseif AwesomeWM.notify.quiet then
    actions_component.instances[index].notification_sound.image = AwesomeWM.assets.get_icon("notification")
  else
    actions_component.instances[index].notification_sound.image = AwesomeWM.assets.get_icon("notificationOn")
  end
end

return actions_component
