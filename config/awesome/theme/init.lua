local theme_m = {}
local b = AwesomeWM.beautiful

theme_m.theme_assets = require("beautiful.theme_assets")
theme_m.xresources = require("beautiful.xresources")
theme_m.dpi = theme_m.xresources.apply_dpi
theme_m.is_dark_theme = true

theme_m.set_wallpaper = function(screen, wallpaper_path)
  screen = screen or AwesomeWM.awful.screen.focused()
  wallpaper_path = wallpaper_path or AwesomeWM.assets.get_wallpaper()

  AwesomeWM.gears.wallpaper.maximized(wallpaper_path, screen, false)
end

theme_m.white = "#F0F1DF"
theme_m.gray = "#2A2D30"
theme_m.black = "#0D0D0D"

theme_m.red = "#ff005c"
theme_m.purple = "#ddaaff"
theme_m.blue = "#60a3d9"
theme_m.green = "#9aeba3"
theme_m.yellow = "#ffe06a"
theme_m.orange = "#F5793B"

theme_m.default_font = "Inconsolata LGC Nerd Font Mono"
theme_m.font = theme_m.default_font .. " 12"

theme_m.tag_active_color = theme_m.red
theme_m.tag_alive_color = theme_m.blue
theme_m.tag_dead_color = theme_m.gray

theme_m.dashboard_inactive_button_bg = theme_m.black
theme_m.dashboard_inactive_button_fg = theme_m.white
theme_m.dashboard_button_border_width = 2
theme_m.dashboard_inactive_button_border_bg = theme_m.white

theme_m.dashboard_active_button_bg = theme_m.red
theme_m.dashboard_active_button_fg = theme_m.white
theme_m.dashboard_active_button_border_bg = theme_m.red

theme_m.init_theme = function()
  b.default_font = theme_m.default_font
  b.font = theme_m.font
  b.nerd_font = b.default_font

  b.white = theme_m.white
	b.gray = theme_m.gray
	b.black = theme_m.black

	b.red = theme_m.red
	b.purple = theme_m.purple
	b.blue = theme_m.blue
	b.green = theme_m.green
	b.yellow = theme_m.yellow
	b.orange = theme_m.orange

  b.useless_gap = theme_m.dpi(3)
  b.border_width = theme_m.dpi(3)

  b.border_normal = b.black
  b.border_focus = b.red
  b.border_sticky = b.yellow
  b.border_marked = b.blue
  b.border_floating = b.purple
  b.border_fullscreen = b.orange

  b.notification_font = b.font
  b.notification_bg = b.black
  b.notification_fg = b.white
  b.notification_opacity = 0.7
  b.notification_critical_bg = b.red
  b.notification_critical_fg = b.black
  b.notification_width = AwesomeWM.values.screen_width * 0.3
  b.notification_height = AwesomeWM.values.screen_height * 0.15
  b.notification_border_color = b.white
  b.notification_border_width = theme_m.dpi(20)

  b.tag_indicator_dead_border_color = b.gray
  b.tag_indicator_dead_background = b.gray

  b.tag_indicator_active_border_color = b.red
  b.tag_indicator_active_background = b.red

  b.tag_indicator_alive_border_color = b.blue
  b.tag_indicator_alive_backgound = b.blue

  b.bg_systray = "#00000000"
  b.systray_icon_spacing = theme_m.dpi(15)
end

return theme_m
