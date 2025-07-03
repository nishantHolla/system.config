local tag_layout = {}
local utils = require("widgets.dashboard.utils")

tag_layout.layout_image = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_layout_icon("fullscreen"),
  resize = true,
  widget = AwesomeWM.wibox.widget.imagebox
})

tag_layout.tray = AwesomeWM.wibox.widget({
  tag_layout.layout_image,
  spacing = 20,
  layout = AwesomeWM.wibox.layout.fixed.horizontal
})

tag_layout.main = utils.margin_box(AwesomeWM.wibox.widget({
  tag_layout.tray,
  valign = "center",
  halign = "center",
  widget = AwesomeWM.wibox.container.place
}), 7)

tag_layout.tags = {}
for _, tag in pairs(AwesomeWM.values.tags) do
  tag_layout.tags[tag.name] = {}

  tag_layout.tags[tag.name].text = AwesomeWM.wibox.widget({
    text = tag.name,
    valign = "center",
    align = "center",
    font = AwesomeWM.theme.default_font .. " 15",
    widget = AwesomeWM.wibox.widget.textbox
  })

  tag_layout.tags[tag.name].button = AwesomeWM.wibox.widget({
    tag_layout.tags[tag.name].text,
    shape_border_width = 3,
    shape = AwesomeWM.gears.shape.rounded_rect,
    shape_border_color = AwesomeWM.theme.green,
    forced_width = 40,
    widget = AwesomeWM.wibox.container.background
  })

  tag_layout.tray:add(tag_layout.tags[tag.name].button)
end

tag_layout.refresh = function()
  tag_layout.layout_image.image = AwesomeWM.assets.get_layout_icon()

  for name, items in pairs(tag_layout.tags) do
    local state = AwesomeWM.functions.tags.get_tag_state(name)

    if state == "alive" then
      items.button.shape_border_color = AwesomeWM.theme.tag_alive_color
      items.button.fg = AwesomeWM.theme.tag_alive_color
    elseif state == "dead" then
      items.button.shape_border_color = AwesomeWM.theme.tag_dead_color
      items.button.fg = AwesomeWM.theme.tag_dead_color
    elseif state == "active" then
      items.button.shape_border_color = AwesomeWM.theme.tag_active_color
      items.button.fg = AwesomeWM.theme.tag_active_color
    end

  end
end

return tag_layout
