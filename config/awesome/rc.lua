AwesomeWM = {}

-- Awesome modules

AwesomeWM.luarocks = pcall(require, "luarocks.loader")
AwesomeWM.awesome = awesome
AwesomeWM.root = root
AwesomeWM.screen = screen
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

-- External modules

AwesomeWM.sharedtags = require("external.sharedtags")

-- User modules

AwesomeWM.values = require("values")
AwesomeWM.notify = require("notify")
AwesomeWM.theme = require("theme")
AwesomeWM.functions = require("functions")
AwesomeWM.keymaps = require("keymaps")
AwesomeWM.assets = require("assets")
AwesomeWM.widgets = require("widgets")
AwesomeWM.services = require("services")

-- Init

AwesomeWM.values.init_values()
AwesomeWM.notify.init_notifications()
AwesomeWM.theme.init_theme()
AwesomeWM.functions.init_error_handling()
AwesomeWM.functions.screens.init_screens()
AwesomeWM.functions.clients.init_clients()
AwesomeWM.keymaps.init_keymaps()

-- Launch apps and services

AwesomeWM.functions.spawn_once("snixembed")
AwesomeWM.functions.spawn_once("nm-applet")
AwesomeWM.functions.spawn_once("tailscale systray &")
AwesomeWM.functions.spawn_once("flameshot")
AwesomeWM.functions.spawn_once("kdeconnect-indicator")
AwesomeWM.functions.spawn_once("picom")
AwesomeWM.functions.spawn_once("blueman-applet")

AwesomeWM.services.battery.start()

local is_resrart = AwesomeWM.functions.check_restart_file()
if is_resrart == false then
  AwesomeWM.functions.network.refresh()
end
