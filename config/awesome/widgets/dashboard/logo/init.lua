local logo_component = {}

logo_component.image = function()
  return AwesomeWM.wibox.widget({
    {
      image = AwesomeWM.assets.get_asset("images/nixos-logo.png"),
      resize = true,
      widget = AwesomeWM.wibox.widget.imagebox
    },
    halign = 'center',
    widget = AwesomeWM.wibox.container.place
  })
end

logo_component.text = function()
  return AwesomeWM.wibox.widget({
    markup = "<b>NixOS</b>",
    font = AwesomeWM.theme.default_font .. " 40",
    valign = "center",
    align = "center",
    widget = AwesomeWM.wibox.widget.textbox
  })
end

logo_component.instances = {}

logo_component.main = function(index)
  return AwesomeWM.wibox.widget({
    logo_component.instances[index].image,
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

  logo_component.instances[index].main = logo_component.main(index)
  logo_component.instances[index].main:ajust_ratio(2, 0.75, 0.25, 0)

  return logo_component.instances[index].main
end

return logo_component
