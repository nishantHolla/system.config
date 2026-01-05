local tags_component = {}
local utils = require("widgets.dashboard.utils")

tags_component.instances = {}

tags_component.layout_image = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_layout_icon("fullscreen"),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

tags_component.tray = function(index)
  return AwesomeWM.wibox.widget({
    tags_component.instances[index].layout_image,
    spacing = 20,
    layout = AwesomeWM.wibox.layout.fixed.horizontal
  })
end

tags_component.main = function(index)
  return utils.margin_box(AwesomeWM.wibox.widget({
    tags_component.instances[index].tray,
    valign = "center",
    halign = "center",
    widget = AwesomeWM.wibox.container.place
  }), 7)
end

tags_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if tags_component.instances[index] ~= nil then
    return tags_component.instances[index].main
  end

  tags_component.instances[index] = {}
  tags_component.instances[index].layout_image = tags_component.layout_image()
  tags_component.instances[index].tray = tags_component.tray(index)
  tags_component.instances[index].main = tags_component.main(index)

  tags_component.instances[index].tags = {}
  for _, t in ipairs(AwesomeWM.values.tags) do
    tags_component.instances[index].tags[t.name] = {}
    tags_component.instances[index].tags[t.name].text = AwesomeWM.wibox.widget({
      text = t.name,
      valign = "center",
      align = "center",
      font = AwesomeWM.theme.default_font .. " 15",
      widget = AwesomeWM.wibox.widget.textbox
    })

    tags_component.instances[index].tags[t.name].box = AwesomeWM.wibox.widget({
      tags_component.instances[index].tags[t.name].text,
      shape_border_width = 3,
      shape = AwesomeWM.gears.shape.rounded_rect,
      shape_border_color = AwesomeWM.theme.green,
      forced_width = 40,
      widget = AwesomeWM.wibox.container.background
    })

    tags_component.instances[index].tray:add(tags_component.instances[index].tags[t.name].box)
  end

  return tags_component.instances[index].main
end

tags_component.refresh = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if tags_component.instances[index] == nil then
    return
  end

  tags_component.instances[index].layout_image.image = AwesomeWM.assets.get_layout_icon()

  for _, t in ipairs(AwesomeWM.values.tags) do
    local state = AwesomeWM.functions.tags.get_tag_state(t.name)

    if state == "alive" then
      tags_component.instances[index].tags[t.name].box.shape_border_color = AwesomeWM.theme.tag_alive_color
      tags_component.instances[index].tags[t.name].box.fg = AwesomeWM.theme.tag_alive_color
    elseif state == "dead" then
      tags_component.instances[index].tags[t.name].box.shape_border_color = AwesomeWM.theme.tag_dead_color
      tags_component.instances[index].tags[t.name].box.fg = AwesomeWM.theme.tag_dead_color
    elseif state == "active" then
      tags_component.instances[index].tags[t.name].box.shape_border_color = AwesomeWM.theme.tag_active_color
      tags_component.instances[index].tags[t.name].box.fg = AwesomeWM.theme.tag_active_color
    end
  end
end

return tags_component
