local logo_component = {}

logo_component.image = function()
  local image = AwesomeWM.wibox.widget({
    image = "",
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  })

  local box = AwesomeWM.wibox.widget({
    image,
    halign = 'center',
    widget = AwesomeWM.wibox.container.place
  })

  return {
    image = image,
    box = box
  }
end

logo_component.text = function()
  return AwesomeWM.wibox.widget({
    font = AwesomeWM.theme.default_font .. " 40",
    valign = "center",
    align = "center",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

logo_component.instances = {}

logo_component.main = function(index)
  return AwesomeWM.wibox.widget({
    logo_component.instances[index].image.box,
    logo_component.instances[index].text,
    widget = AwesomeWM.wibox.layout.ratio.vertical
  })
end

logo_component.create = function(screen)
  screen = screen or AwesomeWM.mouse.screen
  local index = tostring(screen.index)

  if logo_component.instances[index] ~= nil then
    return logo_component.instances[index].main
  end

  logo_component.instances[index] = {
    image = logo_component.image(),
    text = logo_component.text()
  }

  AwesomeWM.functions.user.find_os_name_and(function(name)
    logo_component.instances[index].image.image:set_image(
      AwesomeWM.assets.get_asset("images/" .. name .. "-logo.png")
    )
    local text = name:gsub("^%l", string.upper)
    logo_component.instances[index].text.markup = "<b>" .. text .. "</b>"
  end)
  logo_component.instances[index].main = logo_component.main(index)
  logo_component.instances[index].main:ajust_ratio(2, 0.75, 0.25, 0)

  return logo_component.instances[index].main
end

return logo_component
