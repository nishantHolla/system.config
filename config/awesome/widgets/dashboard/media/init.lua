local media_component = {}
local utils = require("widgets.dashboard.utils")

media_component.prev_button = function()
  return utils.make_icon_button("skipPrevious", function()
    AwesomeWM.functions.player.previous()
  end)
end

media_component.play_pause_button = function()
  return utils.make_icon_button("playPause", function()
    AwesomeWM.functions.player.toggle()
  end)
end

media_component.next_button = function()
  return utils.make_icon_button("skipNext", function()
    AwesomeWM.functions.player.next()
  end)
end

media_component.controls = function()
  return AwesomeWM.wibox.widget({
    media_component.prev_button().main,
    media_component.play_pause_button().main,
    media_component.next_button().main,
    spacing = 20,
    layout = AwesomeWM.wibox.layout.fixed.horizontal
  })
end

media_component.info = function()
  return AwesomeWM.wibox.widget({
    text = "Nothing is playing right now",
    font = AwesomeWM.theme.default_font .. " 16",
    align = "center",
    valign = "center",
    forced_height = 150,
    widget = AwesomeWM.wibox.widget.textbox
  })
end

media_component.instances = {}

media_component.main = function(index)
  return AwesomeWM.wibox.widget({
    media_component.instances[index].info,
    {
      media_component.instances[index].controls,
      halign = "center",
      widget = AwesomeWM.wibox.container.place
    },
    layout = AwesomeWM.wibox.layout.ratio.vertical
  })
end

media_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if media_component.instances[index] ~= nil then
    return media_component.instances[index].main
  end

  media_component.instances[index] = {
    info = media_component.info(),
    controls = media_component.controls()
  }

  media_component.instances[index].main = media_component.main(index)
  media_component.instances[index].main:ajust_ratio(2, 0.75, 0.25, 0)
  return media_component.instances[index].main
end

media_component.refresh = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if media_component.instances[index] == nil then
    return
  end

  AwesomeWM.functions.player.find_metadata_and("title", function(title)
    if title == "" then
      title = "Nothing is playing right now"
    end

    media_component.instances[index].info.text = title
  end)
end

return media_component
