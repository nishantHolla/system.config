AwesomeWM = {}

-- Awesome modules

AwesomeWM.luarocks = pcall(require, "luarocks.loader")
AwesomeWM.awesome = awesome
AwesomeWM.screen = screen
AwesomeWM.root = root
AwesomeWM.tag = tag
AwesomeWM.client = client
AwesomeWM.mouse = mouse
AwesomeWM.gears = require("gears")
AwesomeWM.awful = require("awful")
AwesomeWM.autofocus = require("awful.autofocus")
AwesomeWM.wibox = require("wibox")
AwesomeWM.beautiful = require("beautiful")
AwesomeWM.naughty = require("naughty")
AwesomeWM.menubar = require("menubar")
AwesomeWM.hotkeys_popup = require("awful.hotkeys_popup")
AwesomeWM.hotkeys_popup_keys = require("awful.hotkeys_popup.keys")

-- User modules

AwesomeWM.values = require("values.init")
AwesomeWM.notify = require("notify.init")
AwesomeWM.theme = require("theme.init")
AwesomeWM.functions = require("functions.init")
AwesomeWM.keymaps = require("keymaps.init")
AwesomeWM.assets = require("assets.init")
AwesomeWM.widgets = require("widgets.init")

-- Init

AwesomeWM.values.init_values()
AwesomeWM.notify.init_notifications()
AwesomeWM.theme.init_theme()
AwesomeWM.functions.init_error_handling()
AwesomeWM.functions.screens.init_screens()
AwesomeWM.functions.clients.init_clients()
AwesomeWM.keymaps.init_keymaps()
AwesomeWM.widgets.init_widgets()

-- Launch apps and timers

AwesomeWM.functions.battery.timer:start()
AwesomeWM.functions.spawn("nm-applet")
AwesomeWM.functions.spawn("flameshot")
AwesomeWM.functions.spawn("kdeconnect-indicator")
AwesomeWM.functions.spawn("picom")
