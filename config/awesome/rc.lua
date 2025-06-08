AwesomeWM = {}

-- Awesome modules

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

-- Initialization

AwesomeWM.notify.init_notifications()


AwesomeWM.notify.normal("Hello", "world")
