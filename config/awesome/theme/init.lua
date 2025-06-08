local theme_m = {}
local b = AwesomeWM.beautiful

theme_m.theme_assets = require("beautiful.theme_assets")
theme_m.xresources = require("beautiful.xresources")
theme_m.dpi = theme_m.xresources.apply_dpi

-- Set given wallpaper in the given screen
theme_m.set_wallpaper = function(screen, wallpaper_path)
  screen = screen or AwesomeWM.awful.screen.focused()
  wallpaper_path = wallpaper_path -- or TODO: Get Wallpaper path

  AwesomeWM.gears.wallpaper.maximized(wallpaper_path, screen, false)
end

-- Initialize theme values
theme_m.init_theme = function()
  b.defaultFont = "MartianMono Nerd Font Mono"
  b.font = b.defaultFont .. " 12"
  b.nerdFont = b.defaultFont

  b.white = "#F0F1DF"
  b.gray = "#2A2D30"
  b.black = "#0D0D0D"

  b.red = "#FF005C"
  b.purple = "#DDAAFF"
  b.blue = "#06A3D9"
  b.green = "#09AEBA3"
  b.yellow = "#FFe06A"
  b.orange = "$F5793B"

  b.useless_gap = theme_m.dpi(3)
  b.border_width = theme_m.dpi(3)

  b.border_normal = b.black
  b.border_focus = b.red
  b.border_sticky = b.yellow
  b.border_marked = b.blue
  b.border_floating = b.purple
  b.border_fullscreen = b.orange

  b.notification_fount = b.font
  b.notification_bg = b.black
  b.notification_fg = b.white
  b.notification_opacity = 0.7
  b.notification_critical_bg = b.red
  b.notification_critical_fg = b.black
  b.notification_width = AwesomeWM.values.screen_width * 0.3
  b.notification_height = AwesomeWM.values.screen_height * 0.15
  b.notification_border_color = b.white
  b.notification_border_width = theme_m.dpi(20)
end

return theme_m
