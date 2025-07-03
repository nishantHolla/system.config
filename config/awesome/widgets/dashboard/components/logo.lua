local logo_component = {}

logo_component.image = AwesomeWM.wibox.widget({
  {
    image = AwesomeWM.assets.get_asset("images/nixos-logo.png"),
    resize = true,
    widget = AwesomeWM.wibox.widget.imagebox
  },
  halign = 'center',
  widget = AwesomeWM.wibox.container.place
})

logo_component.text = AwesomeWM.wibox.widget({
  text = "NixOS",
  font = AwesomeWM.theme.default_font .. ' 30',
  valign = "center",
  align = "center",
  widget = AwesomeWM.wibox.widget.textbox
})

logo_component.main = AwesomeWM.wibox.widget({
  logo_component.image,
  logo_component.text,
  widget = AwesomeWM.wibox.layout.ratio.vertical
})

logo_component.main:ajust_ratio(2, 0.75, 0.25, 0)

return logo_component
