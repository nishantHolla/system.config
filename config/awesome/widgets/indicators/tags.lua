local tags_indicator_sm = {}
local base = require("widgets.indicators.base")

tags_indicator_sm.height = base.width
tags_indicator_sm.width = (60 * #AwesomeWM.values.tags) + 60
tags_indicator_sm.margins = base.margins
tags_indicator_sm.padding = 10
tags_indicator_sm.timeout = base.timeout
tags_indicator_sm.opacity = base.opacity

tags_indicator_sm.tag_indicator_dead = AwesomeWM.theme.gray
tags_indicator_sm.tag_indicator_alive = AwesomeWM.theme.blue
tags_indicator_sm.tag_indicator_active = AwesomeWM.theme.red

tags_indicator_sm.layout_icon = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_layout_icon("fullscreen"),
  resize = true,
  forced_width = tags_indicator_sm.height,
  forced_height = tags_indicator_sm.height,
  widget = AwesomeWM.wibox.widget.imagebox
})

tags_indicator_sm.tags = {}

for _, t in pairs(AwesomeWM.values.tags) do
  table.insert(
    tags_indicator_sm.tags,
    AwesomeWM.wibox.widget({
      {
        text = t.name,
        align = "center",
        valign = "center",
        widget = AwesomeWM.wibox.widget.textbox
      },
      shape = AwesomeWM.gears.shape.rounded_rect,
      shape_border_width = 3,
      shape_border_color = tags_indicator_sm.tag_indicator_dead,
      fg = tags_indicator_sm.tag_indicator_dead,
      widget = AwesomeWM.wibox.container.background,
      tag_name = t.name
    })
  )
end

tags_indicator_sm.main = AwesomeWM.wibox.widget({
  {
    tags_indicator_sm.layout_icon,
    margins = tags_indicator_sm.padding,
    widget = AwesomeWM.wibox.container.margin
  },
  layout = AwesomeWM.wibox.layout.flex.horizontal
})

for _, t in pairs(tags_indicator_sm.tags) do
  tags_indicator_sm.main:add(AwesomeWM.wibox.widget({
    t,
    margins = tags_indicator_sm.padding,
    widget = AwesomeWM.wibox.container.margin
  }))
end

tags_indicator_sm.wibox = AwesomeWM.wibox({
  widget = tags_indicator_sm.main,
  visible = true,
  opacity = tags_indicator_sm.opacity,
  ontop = true,
  type = "dock",
  bg = AwesomeWM.theme.black,
  height = tags_indicator_sm.height,
  width = tags_indicator_sm.width,
  shape = AwesomeWM.gears.shape.rounded_rect
})

tags_indicator_sm.init = function()
  AwesomeWM.awful.placement.bottom(tags_indicator_sm.wibox, { margins = base.margins })
end

tags_indicator_sm.timer = AwesomeWM.gears.timer({
  timeout = tags_indicator_sm.timeout,
  callback = function()
    tags_indicator_sm.wibox.visible = false
  end
})

tags_indicator_sm.show = function()
  tags_indicator_sm.layout_icon.image = AwesomeWM.assets.get_layout_icon()
  for _, t in pairs(tags_indicator_sm.tags) do
    local state = AwesomeWM.functions.tags.get_tag_state(t.tag_name)
    if state == "active" then
      t.shape_border_color = tags_indicator_sm.tag_indicator_active
      t.fg = tags_indicator_sm.tag_indicator_active
    elseif state == "alive" then
      t.shape_border_color = tags_indicator_sm.tag_indicator_alive
      t.fg = tags_indicator_sm.tag_indicator_alive
    elseif state == "dead" then
      t.shape_border_color = tags_indicator_sm.tag_indicator_dead
      t.fg = tags_indicator_sm.tag_indicator_dead
    end
  end
  tags_indicator_sm.wibox.visible = true
  tags_indicator_sm.timer:again()
end

return tags_indicator_sm
