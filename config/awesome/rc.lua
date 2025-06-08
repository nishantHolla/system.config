AwesomeWM = {}

-- Awesome modules

AwesomeWM.awesome = awesome
AwesomeWM.root = root
AwesomeWM.screen = screen
AwesomeWM.luarocks = pcall(require, "luarocks.loader")
AwesomeWM.gears = require("gears")
AwesomeWM.awful = require("awful")
AwesomeWM.autofocus = require("awful.autofocus")
AwesomeWM.wibox = require("wibox")
AwesomeWM.beautiful = require("beautiful")
AwesomeWM.naughty = require("naughty")
AwesomeWM.menubar = require("menubar")
AwesomeWM.hotkeysPopup = require("awful.hotkeys_popup")
AwesomeWM.hotkeysPopupKeys = require("awful.hotkeys_popup.keys")

-- User modules

AwesomeWM.values = require("values")
AwesomeWM.notify = require("notify")
AwesomeWM.theme = require("theme")
AwesomeWM.functions = require("functions")

-- Initialization

AwesomeWM.values.init_values()
AwesomeWM.notify.init_notifications()
AwesomeWM.theme.init_theme()
AwesomeWM.functions.init_error_handling()
AwesomeWM.functions.init_screens()

AwesomeWM.notify.normal("Hello", "world")
