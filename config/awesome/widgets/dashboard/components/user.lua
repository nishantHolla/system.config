local user_component = {}
local utils = require("widgets.dashboard.utils")

user_component.user_image = AwesomeWM.wibox.widget({
  image = AwesomeWM.assets.get_asset("images/profile.png"),
  forced_width = 250,
  resize = true,
  widget = AwesomeWM.wibox.widget.imagebox
})

user_component.user_text = AwesomeWM.wibox.widget({
  text = os.getenv("USER"),
  align = "center",
  font = AwesomeWM.theme.default_font .. " 20",
  widget = AwesomeWM.wibox.widget.textbox
})

user_component.user = AwesomeWM.wibox.widget({
  user_component.user_image,
  user_component.user_text,
  spacing = 30,
  layout = AwesomeWM.wibox.layout.fixed.vertical
})

user_component.uptime_text = AwesomeWM.wibox.widget({
  text = "",
  font = AwesomeWM.theme.default_font .. " 16",
  widget = AwesomeWM.wibox.widget.textbox
})

user_component.process_count_text = AwesomeWM.wibox.widget({
  text =  "",
  font = AwesomeWM.theme.default_font .. " 16",
  widget = AwesomeWM.wibox.widget.textbox
})

user_component.info = AwesomeWM.wibox.widget({
  user_component.uptime_text,
  user_component.process_count_text,
  spacing = 5,
  layout = AwesomeWM.wibox.layout.fixed.vertical
})

user_component.layout = AwesomeWM.wibox.widget({
  {
    user_component.user,
    valign = "center",
    widget = AwesomeWM.wibox.container.place
  },
  {
    user_component.info,
    valign = "center",
    widget = AwesomeWM.wibox.container.place
  },
  layout = AwesomeWM.wibox.layout.ratio.horizontal
})

user_component.main = AwesomeWM.wibox.widget({
  user_component.layout,
  margins = 30,
  widget = AwesomeWM.wibox.container.margin
})

user_component.refresh = function()
  AwesomeWM.functions.battery.find_uptime_and(function(uptime)
    user_component.uptime_text.text = "Uptime: " .. uptime
  end)

  AwesomeWM.functions.process.find_process_count_and(function(count)
    user_component.process_count_text.text = "Process Count: " .. count
  end)
end

user_component.layout:ajust_ratio(2, 0.5, 0.5, 0)

return user_component
