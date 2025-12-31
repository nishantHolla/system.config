local tags_indicator_sm = {}
local v = require("widgets.values")

tags_indicator_sm.height = v.indicator_width
tags_indicator_sm.width = (60 * #AwesomeWM.values.tags) + 60
tags_indicator_sm.margins = v.indicator_margins
tags_indicator_sm.padding = v.indicator_padding
tags_indicator_sm.timeout = v.indicator_timeout
tags_indicator_sm.opacity = v.indicator_opacity

tags_indicator_sm.tag_indicator_dead = AwesomeWM.theme.tag_dead_color
tags_indicator_sm.tag_indicator_alive = AwesomeWM.theme.tag_alive_color
tags_indicator_sm.tag_indicator_active = AwesomeWM.theme.tag_active_color

tags_indicator_sm.layout_icon = function()
  return AwesomeWM.wibox.widget({
    image = AwesomeWM.assets.get_layout_icon("fullscreen"),
    resize = true,
    forced_width = tags_indicator_sm.height,
    forced_height = tags_indicator_sm.height,
    widget = AwesomeWM.wibox.widget.imagebox
  })
end

tags_indicator_sm.instances = {}

tags_indicator_sm.main = function(index)
  return AwesomeWM.wibox.widget({
    {
      tags_indicator_sm.instances[index].layout_icon,
      margins = tags_indicator_sm.padding,
      widget = AwesomeWM.wibox.container.margin,
    },
    layout = AwesomeWM.wibox.layout.flex.horizontal,
  })
end

tags_indicator_sm.make_wibox = function(index)
  if tags_indicator_sm.instances[index] ~= nil then
    return
  end

  tags_indicator_sm.instances[index] = {}
  tags_indicator_sm.instances[index].layout_icon = tags_indicator_sm.layout_icon()
  tags_indicator_sm.instances[index].main = tags_indicator_sm.main(index)
  tags_indicator_sm.instances[index].tags = {}

  for _, t in ipairs(AwesomeWM.values.tags) do
    tags_indicator_sm.instances[index].tags[t.name] = {}

    tags_indicator_sm.instances[index].tags[t.name].text = AwesomeWM.wibox.widget({
      text = t.name,
      font = v.indicator_font,
      align = "center",
      valign = "center",
      widget = AwesomeWM.wibox.widget.textbox,
    })

    tags_indicator_sm.instances[index].tags[t.name].background = AwesomeWM.wibox.widget({
      tags_indicator_sm.instances[index].tags[t.name].text,
      shape = AwesomeWM.gears.shape.rounded_rect,
      shape_border_width = 3,
      shape_border_color = tags_indicator_sm.tag_indicator_dead,
      fg = tags_indicator_sm.tag_indicator_dead,
      widget = AwesomeWM.wibox.container.background,
    })

    tags_indicator_sm.instances[index].tags[t.name].margins = AwesomeWM.wibox.widget({
      tags_indicator_sm.instances[index].tags[t.name].background,
      margins = v.indicator_margins,
      widget = AwesomeWM.wibox.container.margin
    })

    tags_indicator_sm.instances[index].main:add(tags_indicator_sm.instances[index].tags[t.name].margins)
  end

  tags_indicator_sm.instances[index].wibox = AwesomeWM.wibox({
    widget = tags_indicator_sm.instances[index].main,
    visible = false,
    opacity = tags_indicator_sm.opacity,
    ontop = true,
    type = "dock",
    bg = AwesomeWM.theme.black,
    height = tags_indicator_sm.height,
    width = tags_indicator_sm.width,
    shape = AwesomeWM.gears.shape.rounded_rect
  })

  tags_indicator_sm.instances[index].timer = AwesomeWM.gears.timer({
    timeout = tags_indicator_sm.timeout,
    callback = function()
      tags_indicator_sm.instances[index].wibox.visible = false
    end
  })
end

tags_indicator_sm.init = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  tags_indicator_sm.make_wibox(index)
  AwesomeWM.awful.placement.bottom(tags_indicator_sm.instances[index].wibox, { margins = v.indicator_margins })
end

tags_indicator_sm.show = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  tags_indicator_sm.instances[index].layout_icon.image = AwesomeWM.assets.get_layout_icon()
  for _, t in ipairs(AwesomeWM.values.tags) do
    local state = AwesomeWM.functions.tags.get_tag_state(t.name)
    local tag_background = tags_indicator_sm.instances[index].tags[t.name].background
    if state == "active" then
      tag_background.shape_border_color = tags_indicator_sm.tag_indicator_active
      tag_background.fg = tags_indicator_sm.tag_indicator_active
    elseif state == "alive" then
      tag_background.shape_border_color = tags_indicator_sm.tag_indicator_alive
      tag_background.fg = tags_indicator_sm.tag_indicator_alive
    elseif state == "dead" then
      tag_background.shape_border_color = tags_indicator_sm.tag_indicator_dead
      tag_background.fg = tags_indicator_sm.tag_indicator_dead
    end
  end

  tags_indicator_sm.instances[index].wibox.visible = true
  tags_indicator_sm.instances[index].timer:again()
end

return tags_indicator_sm
