local user_component = {}
local utils = require("widgets.dashboard.utils")

user_component.instances = {}

user_component.user_image = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_asset("images/profile.png"),
    forced_width = 250,
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

user_component.user_text = function()
  return AwesomeWM.wibox.widget({
    text = os.getenv("USER"),
    align = "center",
    font = AwesomeWM.theme.default_font .. " 20",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

user_component.user = function(index)
  return AwesomeWM.wibox.widget({
    user_component.instances[index].user_image,
    user_component.instances[index].user_text,
    spacing = 20,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })
end

user_component.uptime_text = function()
  return AwesomeWM.wibox.widget({
    text = "",
    font = AwesomeWM.theme.default_font .. " 16",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

user_component.process_count_text = function()
  return AwesomeWM.wibox.widget({
    text = "",
    font = AwesomeWM.theme.default_font .. " 16",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

user_component.info = function(index)
  return AwesomeWM.wibox.widget({
    user_component.instances[index].uptime_text,
    user_component.instances[index].process_count_text,
    spacing = 5,
    layout = AwesomeWM.wibox.layout.fixed.vertical
  })
end

user_component.layout = function(index)
  return AwesomeWM.wibox.widget({
    {
      user_component.instances[index].user,
      valign = "center",
      widget = AwesomeWM.wibox.container.place
    },
    {
      user_component.instances[index].info,
      valign = "center",
      widget = AwesomeWM.wibox.container.place
    },
    layout = AwesomeWM.wibox.layout.ratio.horizontal
  })
end

user_component.main = function(index)
  return AwesomeWM.wibox.widget({
    user_component.instances[index].layout,
    margins = 30,
    widget = AwesomeWM.wibox.container.margin
  })
end

user_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if user_component.instances[index] ~= nil then
    return user_component.instances[index].main
  end

  user_component.instances[index] = {
    user_image = user_component.user_image(),
    user_text = user_component.user_text(),
    uptime_text = user_component.uptime_text(),
    process_count_text = user_component.process_count_text()
  }

  user_component.instances[index].user = user_component.user(index)
  user_component.instances[index].info = user_component.info(index)
  user_component.instances[index].layout = user_component.layout(index)
  user_component.instances[index].main = user_component.main(index)

  user_component.instances[index].layout:ajust_ratio(2, 0.5, 0.5, 0)

  return user_component.instances[index].main
end

user_component.refresh = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if user_component.instances[index] == nil then
    return
  end

  AwesomeWM.functions.user.find_uptime_and(function(uptime)
    user_component.instances[index].uptime_text.text = "Uptime: " .. uptime
  end)


  AwesomeWM.functions.user.find_process_count_and(function(pc)
    user_component.instances[index].process_count_text.text = "Process Count: " .. tostring(pc)
  end)
end

return user_component
