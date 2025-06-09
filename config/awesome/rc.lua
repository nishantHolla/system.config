AwesomeWM = {}

-- Awesome modules

AwesomeWM.luarocks = pcall(require, "luarocks.loader")
AwesomeWM.awesome = awesome
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

AwesomeWM.values = require("values")
AwesomeWM.notify = require("notify")
AwesomeWM.theme = require("theme")
AwesomeWM.functions = require("functions")

-- Init

AwesomeWM.values.init_values()
AwesomeWM.notify.init_notifications()
AwesomeWM.theme.init_theme()
AwesomeWM.functions.init_error_handling()

AwesomeWM.notify.normal("Notification Test", "Ping!")
